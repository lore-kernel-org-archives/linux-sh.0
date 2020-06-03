From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 03 Jun 2020 07:20:08 +0000
Subject: Re: [PATCH v2] sh: Implement __get_user_u64() required for 64-bit get_user()
Message-Id: <b6271c7a-1eaf-61d9-9eb6-061aa8a13ac8@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200531104715.2512247-1-glaubitz@physik.fu-berlin.de>
In-Reply-To: <20200531104715.2512247-1-glaubitz@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, linux-kernel@vger.kernel.org

Hi!

On 5/31/20 12:47 PM, John Paul Adrian Glaubitz wrote:
>  Changes since v1:
>  - Replace single mov instruction for exception handling
>    in case of invalid load

Yutaka Niibe has had a look at my patch and he says, we might have to add
an entry for the fault handling of the upper word.

Quote:

> (1) I think that there is possibility that the second access to user
> space fails (while the first access succeeds).  IIUC, it's good have
> an entry in __ex_tables for the second access too, like:
>     ".long 1b+2, 3b\n\t"
> I don't know if the expression "1b+2" is correct, my intention is
> detecting the failure in the seccond access.

Comments?

@Sato-san: Can you comment on the patch as well?

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
