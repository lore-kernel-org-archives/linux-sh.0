From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 08 May 2015 20:58:31 +0000
Subject: Re: [RFC] i2c-tools: i2ctransfer: add new tool
Message-Id: <20150508225831.63f2d895@endymion.delvare>
List-Id: <linux-sh.vger.kernel.org>
References: <1425053816-19804-1-git-send-email-wsa@the-dreams.de>
	<20150507220812.3776bb83@endymion.delvare>
	<20150508105401.223a8598@endymion.delvare>
	<BLUPR05MB258449826F87ED8A0B25A6BC4DE0@BLUPR05MB258.namprd05.prod.outlook.com>
In-Reply-To: <BLUPR05MB258449826F87ED8A0B25A6BC4DE0@BLUPR05MB258.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Grunwell <rgrunwell@zboost.com>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>

Hi Randy,

On Fri, 8 May 2015 15:28:19 +0000, Randy Grunwell wrote:
> I'm curious why this would not be an extension of the i2c read and write commands? Would it not make sense to add a tier above "Block" (perhaps "Extended"), and use the same syntax?
> 
> Forgive me if this is out of place - I'm quite new, both here and to Linux/C.

No problem, asking questions is fine.

The thing is that this isn't only a question of maximum length. It is
also a question of which kernel interface is being used (ioctl I2C_RDWR
instead of ioctl I2C_SMBUS.) Additionally, i2ctransfer supports any
combination of reading and writing, so in essence it doesn't extend a
specific existing tool, it extends all of them. And the command line
interface will be completely different, whichever we settle for. So it
seems quite obvious that a separate tool is the best way to implement
the feature, as Wolfram did.

-- 
Jean Delvare
SUSE L3 Support
