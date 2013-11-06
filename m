From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 06 Nov 2013 17:55:27 +0000
Subject: RCar-H2: boot from SD card request
Message-Id: <527A828F.4060305@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I am trying to boot an lager board from SD, using SDHI0 channel with
the development branches from Simon.

Has anyone got this to work? I have a working 3.4-ltsi kernel that
can boot

I've tried the next, master and devel branches from
  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git

My current diffs to the source are:

> git diff
> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> index 203bd08..d2b33eb 100644
> --- a/arch/arm/boot/dts/r8a7790-lager.dts
> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> @@ -16,7 +16,7 @@
>         compatible = "renesas,lager", "renesas,r8a7790";
>
>         chosen {
> -               bootargs = "console=ttySC6,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp";
> +               bootargs = "console=ttySC6,38400 ignore_loglevel rw root=/dev/mmcblk0p1 rootwait";
>         };
>
>         memory@40000000 {
> @@ -29,3 +29,5 @@
>                 #size-cells = <1>;
>         };
>  };
> +
> +&sdhi0 { status = "ok"; };

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
