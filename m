From: Luca Santini <luca.santini@spesonline.com>
Date: Wed, 30 Jul 2008 14:06:46 +0000
Subject: Re: i2c_board_info use
Message-Id: <48907576.3080309@spesonline.com>
List-Id: <linux-sh.vger.kernel.org>
References: <48906795.9040101@spesonline.com>
In-Reply-To: <48906795.9040101@spesonline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


can you suggest a new-style driver for inspiration?

thanks

Manuel Lauss wrote:
> Luca Santini wrote:
>> Hi,
>> i'm trying to register (with i2c_board_info()) a wm8731 i2c codec to 
>> solve "SMBus Quick command not supported" problem...
>>
>> but i have no luck... where i'm wrong?
> 
> The Problem is with the wm8731.c codec driver: it still isn't converted
> from old-style I2C probing (attach_adapter / detach_client) to new-style
> (probe/remove). Old-style still requires a working SMBus quick 
> implementation
> in the i2c bus driver.
> 
> So in short, you need to improve the wm8731.c codec.
> 
