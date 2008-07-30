From: Luca Santini <luca.santini@spesonline.com>
Date: Wed, 30 Jul 2008 13:07:33 +0000
Subject: i2c_board_info use
Message-Id: <48906795.9040101@spesonline.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,
i'm trying to register (with i2c_board_info()) a wm8731 i2c codec to 
solve "SMBus Quick command not supported" problem...

but i have no luck... where i'm wrong?


this is the i2c initialization in  my board setup.c code:

<---------------------------

static struct platform_device *edosk7760_devices[] __initdata = {
	&sh7760_i2c0_dev,
	&sh7760_i2c1_dev,
	&smc91x_dev,
};



static struct i2c_board_info __initdata edosk7760_i2c_devices0[] = {
	{
		I2C_BOARD_INFO("WM8731 I2C Codec", 0x1a), //channel 0
		.irq = 62,
	},

	{
		I2C_BOARD_INFO("rtc-clk", 0x68), //channel 0
		.irq = 62,
	},
};


static struct i2c_board_info __initdata edosk7760_i2c_devices1[] = {

  	{
		I2C_BOARD_INFO("h8", 0x66), //channel 1
		.irq = 63,
	},
};



static int __init init_edosk7760_devices(void){
	int ret = -1;

	
	/* Setup smc91c96 Ethernet card: */


	i2c_register_board_info(0, edosk7760_i2c_devices0,
				ARRAY_SIZE(edosk7760_i2c_devices0));
				
	i2c_register_board_info(1, edosk7760_i2c_devices1,
				ARRAY_SIZE(edosk7760_i2c_devices1));
				
	SpesPrint("SPES init_edosk7760 - i2c_register_board_info done \n");


	ret = platform_add_devices(edosk7760_devices, 
ARRAY_SIZE(edosk7760_devices));
	SpesPrint("SPES init_edosk7760 - platform_add_devices done \n");


	return ret;
}
__initcall(init_edosk7760_devices);



<---------------------------



and this the i2c-related dmesg output:


<---------------------------



[    2.842880] i2c /dev entries driver
[    2.842995] device class 'i2c-dev': registering
[    2.843650] bus: 'i2c': add driver dev_driver
[    2.844475] i2c-core: driver [dev_driver] registered
[    2.844550] bus: 'platform': add driver sh7760-i2c
[    2.844671] bus: 'platform': driver_probe_device: matched device 
sh7760-i2c.0 with driver sh7760-i2c
[    2.844743] bus: 'platform': really_probe: probing driver sh7760-i2c 
with device sh7760-i2c.0
[    2.845174] device: 'i2c-0': device_add
[    2.846009] i2c-adapter i2c-0: adapter [SH7760 I2C at fe140000] 
registered
[    2.846100] device: '0-001a': device_add
[    2.846207] bus: 'i2c': add device 0-001a
[    2.846366] i2c 0-001a: uevent
[    2.846940] i2c-adapter i2c-0: client [WM8731 I2C Codec] registered 
with bus id 0-001a
[    2.847038] device: '0-0068': device_add
[    2.847190] bus: 'i2c': add device 0-0068
[    2.847351] i2c 0-0068: uevent
[    2.847927] i2c-adapter i2c-0: client [rtc-clk] registered with bus 
id 0-0068
[    2.848024] device: 'i2c-0': device_add
[    2.848810] i2c-dev: adapter [SH7760 I2C at fe140000] registered as 
minor 0
[    2.848894] sh7760-i2c sh7760-i2c.0: 400 kHz mmio fe140000 irq 62
[    2.849313] driver: 'sh7760-i2c.0': driver_bound: bound to device 
'sh7760-i2c'
[    2.849378] bus: 'platform': really_probe: bound device sh7760-i2c.0 
to driver sh7760-i2c
[    2.849457] bus: 'platform': driver_probe_device: matched device 
sh7760-i2c.1 with driver sh7760-i2c
[    2.849525] bus: 'platform': really_probe: probing driver sh7760-i2c 
with device sh7760-i2c.1
[    2.849884] device: 'i2c-1': device_add
[    2.850961] i2c-adapter i2c-1: adapter [SH7760 I2C at fe150000] 
registered
[    2.851053] device: '1-0066': device_add
[    2.851291] bus: 'i2c': add device 1-0066
[    2.851551] i2c 1-0066: uevent
[    2.852194] i2c-adapter i2c-1: client [h8] registered with bus id 1-0066
[    2.852294] device: 'i2c-1': device_add
[    2.853076] i2c-dev: adapter [SH7760 I2C at fe150000] registered as 
minor 1
[    2.853160] sh7760-i2c sh7760-i2c.1: 400 kHz mmio fe150000 irq 63
[    2.855361] driver: 'sh7760-i2c.1': driver_bound: bound to device 
'sh7760-i2c'
[    2.855427] bus: 'platform': really_probe: bound device sh7760-i2c.1 
to driver sh7760-i2c
[    2.856486] device class 'sound': registering
[    2.857292] Advanced Linux Sound Architecture Driver Version 1.0.16.
[    2.861832] device: 'timer': device_add
[    2.862706] ASoC version 0.13.2
[    2.864971] bus: 'platform': add driver soc-audio
[    2.865750] EDOSK7760 I2S Audio support
[    2.868712] Registering platform device 'soc-audio'. Parent at platform
[    2.868773] device: 'soc-audio': device_add
[    2.868888] bus: 'platform': add device soc-audio
[    2.869629] bus: 'platform': driver_probe_device: matched device 
soc-audio with driver soc-audio
[    2.869710] bus: 'platform': really_probe: probing driver soc-audio 
with device soc-audio
[    2.869825] wm8731: WM8731 Audio Codec 0.13
[    2.872922] bus: 'i2c': add driver WM8731 I2C Codec
[    2.873699] i2c-core: driver [WM8731 I2C Codec] registered
[    2.874887] i2c-adapter i2c-0: SMBus Quick command not supported, 
can't probe for chips
[    2.885000] i2c-adapter i2c-1: SMBus Quick command not supported, 
can't probe for chips
[    2.893040] driver: 'soc-audio': driver_bound: bound to device 
'soc-audio'
[    2.893112] bus: 'platform': really_probe: bound device soc-audio to 
driver soc-audio
[    2.893194] ALSA device list:
[    2.895952]   No soundcards found.






<---------------------------
