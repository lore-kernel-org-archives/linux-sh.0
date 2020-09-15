From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 15 Sep 2020 10:35:28 +0000
Subject: Re: [PATCH] sh: fix syscall tracing
Message-Id: <d641f6a0-0c2d-d7ea-c5e6-b02506200bb5@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200903054803.GX3265@brightrain.aerifal.cx>
 <e456a455-62cd-4f76-a69a-84d1e5b4d153@physik.fu-berlin.de>
 <20200903161639.GE3265@brightrain.aerifal.cx>
 <1a3f0f7e-f6e6-db4e-06ad-9c7d560a6265@physik.fu-berlin.de>
 <20200907174436.GK3265@brightrain.aerifal.cx>
 <3b8d5e6a-38d6-6eca-a49a-69e06680ec1c@physik.fu-berlin.de>
 <c0685f0b-e997-39e9-8ae9-ee22c8e74a01@landley.net>
 <20200910133751.GE3265@brightrain.aerifal.cx>
In-Reply-To: <20200910133751.GE3265@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>, Rob Landley <rob@landley.net>
Cc: linux-sh@vger.kernel.org, Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>

Hi Rich!

On 9/10/20 3:37 PM, Rich Felker wrote:
>> Which I reported to Rich on the 2nd and he had me test a one line patch fixing
>> it (adding an extra #include) on the 3rd, but I just did a fresh pull and the
>> j2_defconfig build still broke a week later.
> 
> Yes, that's presently the other regression fix I have queued for the
> second pull request.

Any news on this? Seems like Linus just tagged -rc5 this week.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
