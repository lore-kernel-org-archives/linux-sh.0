From: Olof Johansson <olof@lixom.net>
Date: Sat, 28 Jan 2012 23:57:43 +0000
Subject: Re: ARM/ARM-SoC plans for v3.4 merge window
Message-Id: <CAOesGMh45HSb4mRMc7q53xhmj_kMFvdVJhNnY7cY6gHi=_KynQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20120123114902.GY1068@n2100.arm.linux.org.uk>
 <20120124095009.GS16726@n2100.arm.linux.org.uk>
 <20120126212319.GE11941@n2100.arm.linux.org.uk>
In-Reply-To: <20120126212319.GE11941@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi,


On Thu, Jan 26, 2012 at 1:23 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:


> And we're now there. =A0So...
>
> Arnd, Olaf,
>
> Please incorporate the latest ARM (for-armsoc branch) changes, which can =
be found at:
>
> =A0 =A0 =A0 =A0git://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/li=
nux-arm.git for-armsoc
>
> with SHA1 dcf81c1af839b77b44404453ecae6e5ac5a75f05.

Thanks. I have added this as depends/rmk/for-armsoc in the arm-soc repo.

Any next/ branch we start will have this as the base of said branch,
so any vendor branches must either already be developed against this
stable branch, or merge on top of this with minimal conflicts.


Thanks!

-Olof
