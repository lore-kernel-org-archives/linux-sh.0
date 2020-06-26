From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 26 Jun 2020 08:41:00 +0000
Subject: Re: [PATCH v3] sh: Implement __get_user_u64() required for 64-bit get_user()
Message-Id: <272f21f0-6128-0316-f302-3e01650eaab4@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200611075811.2949870-1-glaubitz@physik.fu-berlin.de>
 <54a92ee8-e35a-270f-6274-454ffb220a5a@physik.fu-berlin.de>
In-Reply-To: <54a92ee8-e35a-270f-6274-454ffb220a5a@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, NIIBE Yutaka <gniibe@fsij.org>, linux-kernel@vger.kernel.org

Hello!

On 6/17/20 9:52 AM, John Paul Adrian Glaubitz wrote:
>> The changes should be correct now and will hopefully get a positive review by
>> the SH maintainers.
> 
> Ping.
> 
> @Rich, @Yoshinori, @Yutaka, @Michael could I get a review if you have some time?

Can we please move forward with this? I don't want to see another discussion arise
whether SH is maintained or not :-(.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
