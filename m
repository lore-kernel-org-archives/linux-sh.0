From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 05 Jan 2018 22:10:57 +0000
Subject: Re: [J-core] [PATCH v5 00/22] sh: LANDISK and R2Dplus convert to device tree
Message-Id: <bbdfd93b-4234-753b-7127-56f169993c7e@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1467564402-2649-1-git-send-email-ysato@users.sourceforge.jp>
 <c1ec211d-cbe2-1139-edb0-8baa0e7364e8@physik.fu-berlin.de>
 <8c75b447-fc14-871e-1a04-733132527b65@landley.net>
 <E7B2D113-C30D-4A32-AFB6-DC91DDADE0E8@physik.fu-berlin.de>
 <20171117191706.GF1627@brightrain.aerifal.cx>
 <7193aa1b-50e3-11d4-f93d-f567e2e06b8c@physik.fu-berlin.de>
 <20180105212857.GR1627@brightrain.aerifal.cx>
 <c7a8b15d-1399-409f-858c-9bc147bb27c3@physik.fu-berlin.de>
 <20180105220045.GS1627@brightrain.aerifal.cx>
In-Reply-To: <20180105220045.GS1627@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Rob Landley <rob@landley.net>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On 01/05/2018 11:00 PM, Rich Felker wrote:
>> It's a simple bootloader which works with blocklists.
> 
> OK, it's good to know that the lilo program is just stock lilo. So
> is the provided boot.b-selk file (and an appropriate lilo.conf) all
> you need to get it installed on a disk?

If I remember correctly, yes. What you need should be obvious from
the supplied lilo.conf. In order to get LILO to install from my normal
x86 machine, I just bind-mounted the /boot folder of the target hard
disk (CF medium in the case of the USL-5P) and ran the lilo command
with the block device of the target hard disk as a parameter.

It's a bit hacky and it took me some trial and error to get it working,
but I was eventually able to boot a self-compiled kernel on one of
my USL-5Ps. Only issue I initially had was that the bus clock(?) was
set to an incorrect value in the kernel config. With the bus clock
set incorrectly, the kernel would just freeze up.

Oh, and I never managed to get the kernel detect the pseudo-IDE
controller of my USL-5P device. It might work better with your
HDL-160U.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
