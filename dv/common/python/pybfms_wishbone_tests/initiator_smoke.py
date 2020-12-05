'''
Created on Dec 3, 2020

@author: mballance
'''
import cocotb
import pybfms
import wishbone_bfms
from wishbone_bfms.wb_initiator_bfm import WbInitiatorBfm


@cocotb.test()
async def entry(dut):
    print("entry")
    await pybfms.init()
    
    u_bfm : WbInitiatorBfm = pybfms.find_bfm(".*u_bfm")
    print("u_bfm=" + str(u_bfm))
   
    for i in range(10):
        print("--> write")
        await u_bfm.write(0x80000000+4*i, i, 0xF)
        print("<-- write")
        
    pass
