From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 07 Mar 2014 05:36:18 +0000
Subject: Re: Renesas RCar device-tree USB series
Message-Id: <CANqRtoR11xtHsTU3ys5Pvgz_o0UpH3PnzVAc6Xc16vp9s_9MwA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1394128887-4197-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1394128887-4197-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ben,

On Fri, Mar 7, 2014 at 3:01 AM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> This is a new series covering enabling the RCar series of SoCs USB
> with device-tree based booting. It has been tested on the R8A7790
> Lager board.
>
> Improvements from the previous series include:
>
>         - mapping usb to the relevant phy by dt
>         - better use of existing pci of functions
>
> Note, there is still an issue with the second gigabyte of memory on
> the Lager, which with current kernels causes the system to abort on
> startup. This series will only work if the top memory area is disabled.

Thanks for these patches. I think they start looking really good.

In my mind there are two outstanding issues:

1) Is the USB core code change acceptable or not?

The patch "[PATCH 4/9] usb: phy: check for of_node when getting phy"
looks quite fine to me, but I wonder if the USB maintainers will
accept it as-is or require some rework. I would say that the rest of
this series depends on that USB core change.

2) Per-port USB PHY driver configuration via DT

Right now each USB host controller points to the same PHY device.
Thanks for working on describing the topology! As you know, the PHY
driver itself handles several USB ports, and I'd like to use DT to
represent the mapping between which PHY port that maps to what USB
Host controller to allow proper run time configuration. Right now in
this version of the series there is no such mapping. Of course, that
depends on proper USB PHY DT bindings...

Thanks,

/ magnus
