From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Wed, 22 Oct 2008 09:45:14 +0000
Subject: Re: [PATCH] sh: add support FLCTL for ap325rxa board
Message-Id: <48FEF62A.4090603@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <48C63126.5060008@renesas.com>
In-Reply-To: <48C63126.5060008@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Paul Mundt wrote:
> On Tue, Sep 09, 2008 at 05:17:42PM +0900, Yoshihiro Shimoda wrote:
>> This patch adds platform_device for sh_flctl driver, NAND Flash
>> simple partition, and GPIO setting.
>>
>> Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
> 
> Now that the sh_flctl MTD driver has been merged, I have applied this
> patch.

Thank you very much.

>>  static struct i2c_board_info __initdata ap325rxa_i2c_devices[] = {
>> @@ -312,6 +354,16 @@ static void __init ap325rxa_setup(char **cmdline_p)
>>  	ctrl_outw(ctrl_inw(PORT_PSELD) & ~0x0003, PORT_PSELD);
>>  	ctrl_outw((ctrl_inw(PORT_PZCR) & ~0xff00) | 0x5500, PORT_PZCR);
>>  	ctrl_outb((ctrl_inb(PORT_PZDR) & ~0xf0) | 0x20, PORT_PZDR);
>> +
>> +	/* FLCTL */
>> +	ctrl_outw(0, PORT_PUCR);
>> +	ctrl_outw(0, PORT_PVCR);
>> +	ctrl_outw(0, PORT_PSELC);
>> +	ctrl_outw(0, PORT_HIZCRC);
>> +	ctrl_outw(0xFFFF, PORT_DRVCRA);
>> +	ctrl_outw(0xFFFF, PORT_DRVCRB);
>> +	ctrl_outw((ctrl_inw(PORT_PXCR) & 0x3fff) | 0x4000, PORT_PXCR);
>> +	ctrl_outb(0x80, PORT_PXDR);
>>  }
>>
>>  static struct sh_machine_vector mv_ap325rxa __initmv = {
> 
> I checked this part in with your original patch, but have since rewrote
> it to grab all of the FLCTL pins through the new pinmux code. Please make
> sure that it still works for you.

I checked that FLCTL worked correctly using today's sh-2.6.git.

Thanks,
Yoshihiro Shimoda
