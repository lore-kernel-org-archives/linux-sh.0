From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 15 Oct 2015 07:57:11 +0000
Subject: Re: [PATCH/RFC] Simplify Gen3 DU and VSP Kconfig bits
Message-Id: <CANqRtoQm=b0DxAMsghFbar1mmv5uHCUgtDuTJ7pOW=oMoDrRrg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20151015071120.11093.50169.sendpatchset@little-apple>
In-Reply-To: <20151015071120.11093.50169.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Thu, Oct 15, 2015 at 4:16 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Magnus,
>
> Thank you for the patch.
>
> On Thursday 15 October 2015 16:11:20 Magnus Damm wrote:
>> From: Magnus Damm <damm+renesas@opensource.se>
>>
>> Simplify the R-Car DU configuration by removing various Kconfig entires.
>>
>> Without this patch the DU driver has the following entries:
>>  - CONFIG_DRM_RCAR_DU
>>  - CONFIG_DRM_RCAR_HDMI
>>  - CONFIG_DRM_RCAR_LVDS
>>  - CONFIG_DRM_RCAR_VSP
>>
>> With this patch the required entries are reduced to:
>>  - CONFIG_DRM_RCAR_DU
>>
>> This changes simplifies configuration but the downside is obviously
>> larger run time size. We are however talking kilobytes in a world
>> using gigabytes.
>
> We've discussed this in the past and I was a bit dubious regarding the
> usefulness of such a simplification. I especially don't like including the VSP
> glue code unconditionally as it depends on a separate driver.

I agree the dependencies on separate drivers are a bit tricky.

So if we expand the dependencies then we today have:

- CONFIG_DRM_RCAR_DU
-- CONFIG_DRM_RCAR_LVDS
-- CONFIG_DRM_RCAR_HDMI
--- CONFIG_DRM_I2C_ADV7511
-- CONFIG_DRM_RCAR_VSP
---  CONFIG_VIDEO_RENESAS_VSP1

If we clean up things we may end up with:

- CONFIG_DRM_RCAR_DU
-- CONFIG_DRM_I2C_ADV7511
--  CONFIG_VIDEO_RENESAS_VSP1

I think the latter list is more complex enough if we also take DT
nodes into consideration.

Is there any other way we can simplify things, or is the current state
as good as it can ever be?

Cheers,

/ magnus
