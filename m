From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 10 May 2012 05:21:29 +0000
Subject: Re: [PATCH] mach-shmobile: Invalidate caches when booting secondary cores
Message-Id: <CANqRtoTuaofXJaucjBHBVfCucf0ocY9Nhb+2T+Kvb4BOXfRGqA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20120509072459.20583.11420.sendpatchset@w520>
In-Reply-To: <20120509072459.20583.11420.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Wed, May 9, 2012 at 4:24 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm@opensource.se>
>
> Make sure L1 caches are invalidated when booting secondary
> cores. Needed to boot all mach-shmobile SMP systems that
> are using Cortex-A9 including sh73a0, r8a7779 and EMEV2.
>
> Thanks to imx and tegra guys for actual code.
>
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
>
> =A0This should really be moved into a common location. Feel free
> =A0to point me in the right direction and I will be happy to
> =A0submit a patch that unifies the code.
>
> =A0Tested on EMEV2.

Now also successfully tested on the r8a7779 Marzen board.

/ magnus
