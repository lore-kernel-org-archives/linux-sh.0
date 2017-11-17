From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 17 Nov 2017 10:37:55 +0000
Subject: Re: [PATCH v5 00/22] sh: LANDISK and R2Dplus convert to device tree
Message-Id: <c1ec211d-cbe2-1139-edb0-8baa0e7364e8@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1467564402-2649-1-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1467564402-2649-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, j-core@server-01.j-core.org

Hi there!

On 07/03/2016 06:46 PM, Yoshinori Sato wrote:
> SH get devicetree support. But it not working on existing H/W.
> 
> IO-DATA HDL-U (aka landisk) currentry supported.
> This H/W like SH7751 evalution board. It's a best to use this as a
> change base H/W.
> RTS7751R2Dplus is QEMU-SH4 target. So easy trying.

This patch series - which would make a huge improvement - is still not
applied. It would be very useful to be able to test the device tree
implementation with QEMU.

Any of the SH maintainers can apply this?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
