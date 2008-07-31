From: Luca Santini <luca.santini@spesonline.com>
Date: Thu, 31 Jul 2008 15:52:06 +0000
Subject: Re: i2c old to new style conversion
Message-Id: <4891DFA6.8000309@spesonline.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4891CB91.6040308@spesonline.com>
In-Reply-To: <4891CB91.6040308@spesonline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

thanks for redirection Paul.

in the i2c list i found the solution:


in board setup init code you need to register the i2c device:

-----------------
	i2c_register_board_info(0, edosk7760_i2c_devices0,
				ARRAY_SIZE(edosk7760_i2c_devices0));
-----------------


where edosk7760_i2c_devices0 is:

-----------------
static struct i2c_board_info __initdata edosk7760_i2c_devices0[] = {
	{
		I2C_BOARD_INFO("wm8731", 0x1a), //channel 0
		.irq = 62,
	},
};
-----------------



and in the driver you need:

-----------------
static const struct i2c_device_id wm8731_id[] = {
	{ "wm8731", 0 },
	{ }
};
MODULE_DEVICE_TABLE(i2c, wm8731_id);


static struct i2c_driver wm8731_i2c_driver = {
	.driver = {
		.name = "wm8731",
		.owner = THIS_MODULE,
	},

	.probe	= wm8731_i2c_probe,
	.remove	= wm8731_i2c_remove,
	.id_table	= wm8731_id,  // <-- this field is important!
};
-----------------


it's important that i2c_device_id  and I2C_BOARD_INFO name field  (in my 
case "wm8731") are matching.



Paul Mundt wrote:
> On Thu, Jul 31, 2008 at 04:27:56PM +0200, Luca Santini wrote:
>> (diff attached)
>>
>>
>> Hi Manuel,
>> i'm trying the conversion of wm8731 driver and a attach my patch.
>>
>> The problem is: the method wm8731_i2c_probe() - connected to
>> i2c_add_driver.probe field - isn't called and alsa says "No Soundcard
>> found".
>>
>>
>> in the old style driver the method wm8731_codec_probe()  - connected to
>> i2c_add_driver.attach_adapter field -  is called during initialization
>> by i2c_add_driver() .
>>
>> How to call wm8731_i2c_probe()? Do i miss something?
>>
>>
> 
> You should be sending this inquiry to the i2c list, where someone might
> be able to help you with i2c related problems.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
