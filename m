From: Rob Landley <rob@landley.net>
Date: Fri, 17 Nov 2017 17:39:48 +0000
Subject: Re: [J-core] [PATCH v5 00/22] sh: LANDISK and R2Dplus convert to device tree
Message-Id: <8c75b447-fc14-871e-1a04-733132527b65@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1467564402-2649-1-git-send-email-ysato@users.sourceforge.jp>
 <c1ec211d-cbe2-1139-edb0-8baa0e7364e8@physik.fu-berlin.de>
In-Reply-To: <c1ec211d-cbe2-1139-edb0-8baa0e7364e8@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Rich Felker <dalias@libc.org>

On 11/17/2017 04:37 AM, John Paul Adrian Glaubitz wrote:
> Hi there!
> 
> On 07/03/2016 06:46 PM, Yoshinori Sato wrote:
>> SH get devicetree support. But it not working on existing H/W.
>>
>> IO-DATA HDL-U (aka landisk) currentry supported.
>> This H/W like SH7751 evalution board. It's a best to use this as a
>> change base H/W.
>> RTS7751R2Dplus is QEMU-SH4 target. So easy trying.
> 
> This patch series - which would make a huge improvement - is still not
> applied. It would be very useful to be able to test the device tree
> implementation with QEMU.
> 
> Any of the SH maintainers can apply this?

It's Rich's call, but given that it's _from_ one of the sh maintainers,
sounds to me like it can just go in if it still applies? (If there's
bugfixes needed they can go in -rc2 or so, after this merge window.)

Given that qemu serial's been broken for 9 months now, I doubt this
would make anything worse. (I should really check Cedric's qemu fork to
see if he fixed that...)

Rob
