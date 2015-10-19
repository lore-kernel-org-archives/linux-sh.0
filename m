From: Hans Verkuil <hansverk@cisco.com>
Date: Mon, 19 Oct 2015 14:54:53 +0000
Subject: Re: [PATCH/RFT 0/7] HDMI capture on Lager
Message-Id: <5625043D.5010007@cisco.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1445263660-6945-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1445263660-6945-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 10/19/2015 04:07 PM, Ulrich Hecht wrote:
> Hi!
>
> This series is supposed to serve as a basis for testing the HDMI input on
> the Lager board.  It is based on the series by William Towle, dropping the
> patches that have since been merged, and adding the interrupt to the adv7612
> DT description.
>
> The base of this series, Laurent's "pad config allocator" patch, had been
> deferred pending a retooling of the media controller framework.  I could
> not, however, find significant activity in that area (read: the patch still
> applies)...
>
> With this series applied I was able to capture the top left quarter of the
> output of my Raspberry Pi.  Whether this meager result is caused by the
> input device, the output device, the userland software, or me, I have yet to
> find out.  I suspect the latter, as I have last used VIN on Linux with an
> Iomega Buz...

Please cross-post this to the linux-media mailinglist, otherwise it will 
likely be lost.

BTW a lot of work is being done in the media controller framework, but 
nothing has been merged yet. It looks likely to be merged for kernel 4.5.

Regards,

	Hans

>
> CU
> Uli
>
>
> Ian Molton (1):
>    ARM: shmobile: lager dts: specify default-input for ADV7612
>
> Laurent Pinchart (1):
>    v4l: subdev: Add pad config allocator and init
>
> Rob Taylor (1):
>    media: soc_camera: soc_scale_crop: Use correct pad number in try_fmt
>
> William Towle (4):
>    media: soc_camera pad-aware driver initialisation
>    media: rcar_vin: Use correct pad number in try_fmt
>    ARM: shmobile: lager dts: Add entries for VIN HDMI input support
>    media: adv7604: automatic "default-input" selection
>
>   arch/arm/boot/dts/r8a7790-lager.dts                | 41 +++++++++++++++++++++-
>   drivers/media/i2c/adv7604.c                        | 25 +++++++++----
>   drivers/media/platform/soc_camera/Kconfig          |  1 +
>   drivers/media/platform/soc_camera/rcar_vin.c       | 18 +++++++---
>   drivers/media/platform/soc_camera/soc_camera.c     | 20 ++++++++++-
>   drivers/media/platform/soc_camera/soc_scale_crop.c |  1 +
>   drivers/media/v4l2-core/v4l2-subdev.c              | 19 +++++++++-
>   include/media/soc_camera.h                         |  1 +
>   include/media/v4l2-subdev.h                        | 10 ++++++
>   9 files changed, 121 insertions(+), 15 deletions(-)
>

