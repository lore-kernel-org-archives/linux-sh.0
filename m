From: Federico Fuga <ml@studiofuga.com>
Date: Sat, 14 May 2011 10:36:51 +0000
Subject: Poor serial (sh-shi) performance on sh7302
Message-Id: <31CA096C-1FCD-4DDC-9393-4BDB8D0526FD@studiofuga.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi everybody,

I am developing a board with an sh 7302 cpu, and Linux-SH kernel 2.6.37.
Some week ago I posted here a problem with a spurious serial interrupt that locked-out the kernel.
I have isolated the problem with a unhandled overrun of the 16bytes FIFO. I solved the problem with a patch - soon posted here for reference.
But the problem was only an effect of a greater problem, that is the fact that the serial driver isn't able to handle a serial stream in time.
I made the following test: opened a console, set it at low speed (9600bps), then copied some text - at least 17 chars - in the clipboard of my PC; when pasting that chars on the terminal window, the overruns occurs.
Example: I typed 

echo "

then pasted the string "0123456789ABCDEFGHI" on the terminal window.
this is what appears on the terminal:

~ # echo "sh-sci sh-sci.0: overrun error
0123456789ABCDEF

Note that the serial port is set at 9600bps. 
Note also that only 16bytes are read from the serial port, this means (as I understand correctly) that no bytes are read from the FIFO before the buffer overruns.
Since 16 bytes enter the fifo in 16*1/1200 = 13ms, this means that it needs more than 13ms to the CPU to process the interrupt and start reading the FIFO! it's a ugly performance!
I tried many different kernel and scheduler configurations (preemptive, non-preemptive, cached, uncached, 100Hz, 1000Hz) but nothing changes. I suppose that the problem could be in the interrupt handling, but I do not know much of the internals, so I am ask you if there is some improvement I can try to increase the responsiveness of the serial port.
Note that while in uboot, I can set up the serial port at 115200bps and sustain this transfer speed without problem.

Thank you in advance!

Best regards


Federico Fuga



