'''
Created on Nov 21, 2020

@author: mballance
'''

import pybfms

@pybfms.bfm(hdl={
    pybfms.BfmType.Verilog : pybfms.bfm_hdnl_path(__file__, "hdl/wb_initiator_bfm.v"),
    pybfms.BfmType.SystemVerilog : pybfms.bfm_hdnl_path(__file__, "hdl/wb_initiator_bfm.v"),
    }, has_init=True)
class WbInitiatorBfm():


    def __init__(self):
        self.busy = pybfms.lock()
        self.ack_ev = pybfms.event()
        self.addr_width = 0
        self.data_width = 0
        
    async def write(self, adr, dat, sel):
        await self.busy.acquire()
        self._access_req(adr, dat, 1, sel)
        
        await self.ack_ev.wait()
        self.ack_ev.clear()
        
        self.busy.release()
        
    @pybfms.import_task(pybfms.uint64,pybfms.uint64,pybfms.uint8,pybfms.uint8)
    def _access_req(self, adr, dat, we, sel):
        pass
    
    @pybfms.export_task(pybfms.uint64)
    def _access_ack(self, dat_i):
        self.dat_i = dat_i
        self.ack_ev.set()
        
    @pybfms.export_task(pybfms.uint32,pybfms.uint32)
    def _set_parameters(self, addr_width, data_width):
        self.addr_width = addr_width
        self.data_width = data_width
