From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 12 Jan 2017 14:08:01 +0000
Subject: Re: SH builds broken due to kisskb toolchain upgrade
Message-Id: <92532cf8-abbc-ccc2-da23-21176eebd98f@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdWmo9bnpWucQP6ZYbpFXVL73DDmfJE+ZgeTKAxC6LcrrQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWmo9bnpWucQP6ZYbpFXVL73DDmfJE+ZgeTKAxC6LcrrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On 01/12/2017 02:39 PM, Geert Uytterhoeven wrote:
> Last good version:
> 
>     http://kisskb.ellerman.id.au/kisskb/buildresult/12857088/
>     sh4-linux-gcc (GCC) 4.6.3
> 
> First bad version:
> 
>     http://kisskb.ellerman.id.au/kisskb/buildresult/12857629/
>     sh4-linux-gcc.br_real (Buildroot 2016.11-git-00613-ge98b4dd) 5.4.0
> 
> Both versions build fine with the compiler I'm using (gcc 4.6.3 from
> kernel.org crosstool).

A recent version of gcc-5 should work fine on SH. We've been using gcc-5
in Debian for a while now to build the kernel package on sh4 without
any issues.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
