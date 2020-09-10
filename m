From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 10 Sep 2020 09:55:14 +0000
Subject: Re: [PATCH] sh: fix syscall tracing
Message-Id: <3b8d5e6a-38d6-6eca-a49a-69e06680ec1c@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200903054803.GX3265@brightrain.aerifal.cx>
 <e456a455-62cd-4f76-a69a-84d1e5b4d153@physik.fu-berlin.de>
 <20200903161639.GE3265@brightrain.aerifal.cx>
 <1a3f0f7e-f6e6-db4e-06ad-9c7d560a6265@physik.fu-berlin.de>
 <20200907174436.GK3265@brightrain.aerifal.cx>
In-Reply-To: <20200907174436.GK3265@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>

Hi Rich!

On 9/7/20 7:44 PM, Rich Felker wrote:
>> Can we still get this merged as a hotfix for 5.9?
> 
> Yes, fixes for regressions in the same release cycle are in-scope (the
> whole point of having -rc's). I have at least one other fix that needs
> to go in too and was just giving it a little time to make sure
> everything's ok now and that there are no more.

Let me know if there is anything else left for testing.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
