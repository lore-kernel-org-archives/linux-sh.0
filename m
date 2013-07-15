From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 15 Jul 2013 21:54:02 +0000
Subject: Help with fitting unusual devices into IIO framework
Message-Id: <51E46F7A.9020400@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Hello.

     Recently I have posted a driver for drivers/misc/ driving a pair of 
devices: Renesas R-Car Gyro-ADC and speed-pulse interfaces [1]. Arnd 
Bergmann, one of the maintainers told me that such driver would fit 
better into the IIO infrastructure. I have studied this infrastructure
for some time and only found in it a place for the Gyro-ADC interface.
    Let me describe the devices to be driven in some detail. Gyro-ADC 
i/f is an interface to multichannel serial ADC (of 3 certain models)
which can also calculate and average of each 8 samples and sum up 10 of 
these average values. Speed-pulse interface can count PWM-type input 
signal pulses and period between them. Though  being two separate 
devices, these two have to be driven together because of the shared 
start/stop register (located in Gyro-ADC i/f still) and the clock with 
1.25 ms period supplied from the Gyro-ADC i/f to the speed-pulse i/f;
at the same time speed-pulse i/f generates interrupt with 100 ms period 
to be used by both interfaces.
    At this time, only speed-pulse interface support is required, 
Gyro-ADC can be largely ignored (though it has to be initialized). 
Perhaps we could add a new I/O channel type for speed-pulse i/f? What's 
your thoughts?

[1] marc.info/?l=linux-kernel&m7367311823027

WBR, Sergei
