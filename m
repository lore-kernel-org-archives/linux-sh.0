From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 05 Jan 2018 21:47:34 +0000
Subject: Re: [J-core] [PATCH v5 00/22] sh: LANDISK and R2Dplus convert to device tree
Message-Id: <c7a8b15d-1399-409f-858c-9bc147bb27c3@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1467564402-2649-1-git-send-email-ysato@users.sourceforge.jp>
 <c1ec211d-cbe2-1139-edb0-8baa0e7364e8@physik.fu-berlin.de>
 <8c75b447-fc14-871e-1a04-733132527b65@landley.net>
 <E7B2D113-C30D-4A32-AFB6-DC91DDADE0E8@physik.fu-berlin.de>
 <20171117191706.GF1627@brightrain.aerifal.cx>
 <7193aa1b-50e3-11d4-f93d-f567e2e06b8c@physik.fu-berlin.de>
 <20180105212857.GR1627@brightrain.aerifal.cx>
In-Reply-To: <20180105212857.GR1627@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Rob Landley <rob@landley.net>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On 01/05/2018 10:28 PM, Rich Felker wrote:
> I'm trying to reproduce this but can't find any documentation for
> cross-LILO in [2], much less any code except possibly the binary
> "lilo.x86" in [1]. Googling cross-lilo isn't finding anything
> meaningful except this thread. Is there anywhere to find source and
> information on what it's doing, or is this going to be something I
> have to reverse-engineer?

It's just LILO for x86, nothing fancy. You could as well just download
LILO, build it for x86 and then use it to install the bootloader onto
the harddisk/CF medium you are using on the LANDISK.

Source code for LILO can be found here: https://lilo.alioth.debian.org/

It's a simple bootloader which works with blocklists.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
