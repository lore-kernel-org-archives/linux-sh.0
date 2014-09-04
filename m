From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 04 Sep 2014 02:36:16 +0000
Subject: Re: [PATCH 04/05] ARM: shmobile: armadillo800eva reference: Remove C board code
Message-Id: <CANqRtoSCT1qx1oL-Up3cNdy0qvfe=Ej=xC7F1BxMexpwL6JXFg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140828033518.18867.19496.sendpatchset@w520>
In-Reply-To: <20140828033518.18867.19496.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 28, 2014 at 12:35 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> Now when the r8a7740 generic multiplatform case has the same
> features as the DT reference board code then get rid of the
> Armadillo800EVA DT reference C board code. DT Reference code
> in the future shall make use of the r8a7740 Multiplatform
> support code with the generic SoC machine vector.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
>
>  arch/arm/mach-shmobile/Kconfig                           |   15 -
>  arch/arm/mach-shmobile/Makefile                          |    1
>  arch/arm/mach-shmobile/Makefile.boot                     |    1
>  arch/arm/mach-shmobile/board-armadillo800eva-reference.c |  199 --------------
>  4 files changed, 216 deletions(-)

Hi Simon,

Thanks for your help picking up this series. I noticed that in your
git repository this particular patch is missing the Kconfig and
Makefile bits. If this is intentional and you intend to remove those
portions in a separate patch somewhere down the line then that's of
course fine with me. If not then please consider including them. =)

Cheers,

/ magnus
