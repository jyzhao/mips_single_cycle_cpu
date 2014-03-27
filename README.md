mips_single_cycle_cpu
=====================

MIPS Single Cycle CPU, ECE 437, Purdue University

Single Cycle Processor

This lab requires you to implement a single cycle processor similar to the one discussed in lecture. This is a multiweek lab, so budget your time accordingly. You will be making components for your single cycle processor (these components can also be reused for your other processors).

Note
The main difference between the processor described in the book and the one in lab is the use of one memory instead of two (Instruction and Data).
Design

lab4__1.png
Figure 1. Hierarchy
This hierarchy will be similar for all of the processor designs you will do this semester. The system is the top level block that interfaces with the system_tb. Inside it are two components, ram and cpu. The first component, ram, (which will be provided to you) is your memory which holds your instructions and data. The second, cpu is your design, in this case a single cycle processor. The term single cycle is not entirely accurate as memory latency and structural resource limitations may cause more than one cycle to elapse before the instruction is officially complete.

Your design will consist of a few components, first the datapath will guide the flow of bits to the register_file, control_unit, request_unit, and alu. The control_unit will set the flow of the datapath to execute an instruction. The register_file holds values that instructions compute and use to access memory, or do compute tasks. This is the same structure you made in your previous lab. The request_unit will detect when memory requests are completed in the datapath and take actions to deassert the memory request. Finally, the alu is your functional unit or execute unit, it does operations on data and produces results.

The datapath will connect to a cache layer, this layer is not functional for this processor. It will be a pass-through layer. This means that signals coming from the datapath will pass through the caches and go to the memory_control. Later in the semester we will have you build a functional cache layer. The course staff may also decide to plug a functional cache layer into your design when you submit it for testing.

The final piece is the memory_control, this component talks to ram and relays that information to the datapath. This component needs to arbitrate the ram between instruction fetch and the load/store of data as there is only one port on the ram only one of those actions can take place. It will give priority to the data operations. It is the job of the memory_control to ensure smooth utilization of ram. This is illustrated in the following figure.

lab4__2.png
Figure 2. System Connectivity
Design Specification

You will be given interfaces to use in your design. These interfaces are to help you with signals connecting components, and to facilitate the interopability between your design and components developed by the course staff.

The ram is a variable latency ram, which means it will take time to output data from the desired address. This relates to your design as there is only one clock domain.

The following packages and interfaces will be provided (see the Files section):

Packages
CPU types: This contains data types for your processor design.

Interfaces
CPU Ram: Connects your cpu to ram.

Datapath Cache: Connects your datapath to the caches.

Cache Control: Connects your caches to memory_control.

System: Connects the system to the testbench and fpga wrapper.

The use of these packages and interfaces is required in your design. These can not be modified, or changed in any way by you the student.

Important
Only the course staff may make changes to the interfaces. Should changes be necessary, you will be instructed to pull from the git repository to merge these changes.
The following will be the specification for the single cycle processor:

Processor Specifications
Use of provided interfaces and packages.

Ability to execute the ISA specified by asm -i, excluding pseudo operations and LL/SC instructions.

Maintain modularity specified by hierarchy diagram (course components can be interchanged with student components).

Instructions and data are 32 bits wide.

Tolerable of variable latency memory.

Properly stops execution of memory operations when halted.

Memory enable signals are deasserted.

Branches must be evaluated before the following instruction is executed.

Setup

You will be working in the same repository processors that you have used previously in lab. Switch back to the master branch.

git checkout master

Note
You need to merge branches before branching for this processor design.
From the master branch, issue the following commands:

git checkout -b singlecycle

git pull origin singlecycle

Files
The following files contain the package and interfaces that are required in this design.

packages: cpu_types_pkg.vh

interfaces: cpu_ram_if.vh, datapath_cache_if.vh, cache_control_if.vh, system_if.vh

You should also have the following component files:

System Components
system.sv

system_fpga.sv

system_tb.sv

ram.sv

These files are templates to guide you in the design of your processor. They contain no functionality.

Processor Components
singlecycle.sv

datapath.sv

caches.sv

memory_control.sv

Deliverables

You will be required to create testbench files for components used in this design, as well as fpga wrapper files. You are also required to create a block diagram for your processor with dia or another diagramming program. Hand drawn diagrams will not be accepted.

Important
Failure to turn in a diagram of your processor when specified on the evaluation sheet will constitute a grade of zero for that evaluation sheet.
You can find the evaluation sheets for lab3 and lab4 linked respectively.

The deliverables for the single cycle lab:

Block diagram of your processor.

HDL code for verified functional components.

All components fully connected to form the processor.

Testbench programs and fpga wrappers for components.

Control Unit

Test each opcode is identified.

Verify signals perform correct mux operation.

Request Unit

Document test cases.

Test signal combinations to simulate completing memory operation.

Memory Control Unit

Document test cases.

Test signal combinations to simulate memory usage.

Completed evaluation sheets for the respective labs.

Electronic submission of your design.

You must turn in your design to receive points from the grading script. You may do this by running the submit script from the processors directory. See the tutorial lab for a refresher, if one is required.

Last updated 2014-02-05 11:47:19 EST
