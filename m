From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 01 Aug 2013 09:39:16 +0000
Subject: Re: [RFC 2/5] arm: boot: allow zboot with appended DTB
Message-Id: <CANqRtoThVs9o4hwYm4pVcnQX+oPA563cbbMkLbFh=T7yhiY87g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

On Wed, Jul 31, 2013 at 2:57 AM, Ulrich Hecht <ulrich.hecht@gmail.com> wrote:
> I don't see any reason why this should not be allowed.
> ---
>  arch/arm/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 0ac9be6..54ac595 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1938,7 +1938,7 @@ endchoice
>
>  config ARM_APPENDED_DTB
>         bool "Use appended device tree blob to zImage (EXPERIMENTAL)"
> -       depends on OF && !ZBOOT_ROM
> +       depends on OF
>         help
>           With this option, the boot code will look for a device tree binary
>           (DTB) appended to zImage
> --
> 1.7.10.4

Thanks for your patches. I'm not sure about the reason behind this
!ZBOOT_ROM - perhaps the kernel should run from ROM initially somehow
and shouldn't be overwritten?

Regardless I believe the code handles DTB automatically in
arch/arm/boot/compressed/head-shmobile.S - at least in recent
renesas.git (I checked renesas-devel-20130801).

So based on that I don't think you need this patch. At least I've been
able to boot a zImage via USB Mask ROM on Mackerel with appended DTB
without setting ARM_APPENDED_DTB. The reason to special case our DTB
handling is that the MERAM used for DTB storage while booting from USB
Mask ROM can't really be used to pass the DTB to the kernel - so
because of that we need to relocate our DTB to RAM early on.

Cheers,

/ magnus
