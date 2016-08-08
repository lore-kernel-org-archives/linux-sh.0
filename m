From: Andreas Schwab <schwab@linux-m68k.org>
Date: Mon, 08 Aug 2016 17:02:38 +0000
Subject: Re: Build regressions/improvements in v4.8-rc1
Message-Id: <87shufi47l.fsf@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
References: <alpine.DEB.2.10.1608081032130.9359@ayla.of.borg>
	<CAMuHMdW_fPP5dyOtRC98gh1kG-zuW_KxV7vAME_7b8Z-U10N_g@mail.gmail.com>
	<20160808143139.GW15995@brightrain.aerifal.cx>
	<CAMuHMdWKXTdxa451_E11zmmsW5ZzCQ=z4qMnp-ZLGSZmfGB5VQ@mail.gmail.com>
	<20160808162204.GX15995@brightrain.aerifal.cx>
In-Reply-To: <20160808162204.GX15995@brightrain.aerifal.cx> (Rich Felker's
	message of "Mon, 8 Aug 2016 12:22:04 -0400")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>

On Mo, Aug 08 2016, Rich Felker <dalias@libc.org> wrote:

> Users should leave builtin-DTB off, but allyesconfig turns it on.

Perhaps you could inverse the meaning of the config so that y means
builtin-DTB off?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
