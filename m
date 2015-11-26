From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 26 Nov 2015 18:26:49 +0000
Subject: Re: [PATCH] drm: rcar-du: Perform initialization/cleanup at probe/remove time
Message-Id: <1672184.5pWpzmZmYm@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1445295114-20921-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <2416796.7aKg1mPfX6@avalon> <20151021153945.GI16848@phenom.ffwll.local>
In-Reply-To: <20151021153945.GI16848@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org

Hi Daniel,

On Wednesday 21 October 2015 17:39:45 Daniel Vetter wrote:
> On Wed, Oct 21, 2015 at 06:16:08PM +0300, Laurent Pinchart wrote:
> > On Tuesday 20 October 2015 09:32:13 Daniel Vetter wrote:
> >> On Tue, Oct 20, 2015 at 01:51:54AM +0300, Laurent Pinchart wrote:
> >>> The drm driver .load() operation is prone to race conditions as it
> >>> initializes the driver after registering the device nodes. Its usage
> >>> is deprecated, inline it in the probe function and call
> >>> drm_dev_alloc() and drm_dev_register() explicitly.
> >>> 
> >>> For consistency inline the .unload() handler in the remove function as
> >>> well.
> >>> 
> >>> Signed-off-by: Laurent Pinchart
> >>> <laurent.pinchart+renesas@ideasonboard.com>
> >>> ---
> >>> 
> >>>  drivers/gpu/drm/rcar-du/rcar_du_drv.c     | 184 +++++++++++----------
> >>>  drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c |  11 +-
> >>>  drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c |  11 +-
> >>>  drivers/gpu/drm/rcar-du/rcar_du_vgacon.c  |  11 +-
> >>>  4 files changed, 104 insertions(+), 113 deletions(-)
> >>> 
> >>> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> >>> b/drivers/gpu/drm/rcar-du/rcar_du_drv.c index
> >>> bebcc97db5e5..46d628752371
> >>> 100644
> >>> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> >>> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> > 
> > [snip]
> > 
> >>> -static int rcar_du_remove(struct platform_device *pdev)
> >>> +static int rcar_du_probe(struct platform_device *pdev)
> >>>  {
> >>> -	struct rcar_du_device *rcdu = platform_get_drvdata(pdev);
> >>> +	struct device_node *np = pdev->dev.of_node;
> >>> +	struct rcar_du_device *rcdu;
> >>> +	struct drm_connector *connector;
> >>> +	struct drm_device *ddev;
> >>> +	struct resource *mem;
> >>> +	int ret;
> >>> +
> >>> +	if (np = NULL) {
> >>> +		dev_err(&pdev->dev, "no device tree node\n");
> >>> +		return -ENODEV;
> >>> +	}
> >>> +
> >>> +	/* Allocate and initialize the DRM and R-Car device structures. */
> >>> +	rcdu = devm_kzalloc(&pdev->dev, sizeof(*rcdu), GFP_KERNEL);
> >>> +	if (rcdu = NULL)
> >>> +		return -ENOMEM;
> >>> +
> >>> +	init_waitqueue_head(&rcdu->commit.wait);
> >>> 
> >>> -	drm_put_dev(rcdu->ddev);
> >>> +	rcdu->dev = &pdev->dev;
> >>> +	rcdu->info = of_match_device(rcar_du_of_table, rcdu->dev)->data;
> >>> +
> >>> +	ddev = drm_dev_alloc(&rcar_du_driver, &pdev->dev);
> >>> +	if (!ddev)
> >>> +		return -ENOMEM;
> >>> +
> >>> +	rcdu->ddev = ddev;
> >>> +	ddev->dev_private = rcdu;
> >>> +
> >>> +	platform_set_drvdata(pdev, rcdu);
> >>> +
> >>> +	/* I/O resources */
> >>> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >>> +	rcdu->mmio = devm_ioremap_resource(&pdev->dev, mem);
> >>> +	if (IS_ERR(rcdu->mmio)) {
> >>> +		ret = PTR_ERR(rcdu->mmio);
> >>> +		goto error;
> >>> +	}
> >>> +
> >>> +	/* Initialize vertical blanking interrupts handling. Start with 
> >>> vblank
> >>> +	 * disabled for all CRTCs.
> >>> +	 */
> >>> +	ret = drm_vblank_init(ddev, (1 << rcdu->info->num_crtcs) - 1);
> >>> +	if (ret < 0) {
> >>> +		dev_err(&pdev->dev, "failed to initialize vblank\n");
> >>> +		goto error;
> >>> +	}
> >>> +
> >>> +	/* DRM/KMS objects */
> >>> +	ret = rcar_du_modeset_init(rcdu);
> >>> +	if (ret < 0) {
> >>> +		dev_err(&pdev->dev, "failed to initialize DRM/KMS (%d)\n", ret);
> >>> +		goto error;
> >>> +	}
> >>> +
> >>> +	ddev->irq_enabled = 1;
> >>> +
> >>> +	/* Register the DRM device with the core and the connectors with
> >>> +	 * sysfs.
> >>> +	 */
> >>> +	ret = drm_dev_register(ddev, 0);
> >>> +	if (ret)
> >>> +		goto error;
> >>> +
> >>> +	mutex_lock(&ddev->mode_config.mutex);
> >>> +	drm_for_each_connector(connector, ddev) {
> >>> +		ret = drm_connector_register(connector);
> >>> +		if (ret < 0)
> >>> +			break;
> >>> +	}
> >>> +	mutex_unlock(&ddev->mode_config.mutex);
> >> 
> >> I'm wondereding whether we shouldn't just wrap this up in a helper
> >> somehow, like drm_dev_modeset_register.
> > 
> > How about drm_connector_plug_all() to match the existing
> > drm_connector_unplug_all() ?
> 
> plug/unplug has for me a different meaning wrt connectors. And because of
> the MST problem I'd just leave this along really.
> 
> >> Only trouble is that we might be racing with adding MST connectors
> >> already, and that's where I stopped thinking about it ;-)
> > 
> > You'll have to brief me on the MST issue if you want my opinion on the
> > matter :-)
> 
> MST can hot-add connectors, and we can do that as soon as we process
> hotplug events. Which is generally towards the end of the init sequence,
> but decidedly before drm_dev_register().
> 
> So a function which walks all connectors (even when holding relevant
> locks) could try to double-register a connector added through MST hotplug,
> leading to slight unpleasantries.
> 
> But since this is hard I didn't think up an idea for how to address this.
> Since there's also the question whether the hotplug uevent will fare well
> before the drm_dev_register() call ...

We've more or less successfully avoided thinking about dynamic addition and 
removal of encoders and CRTCs so far, and support for dynamically added 
connectors is probably also not as generic as it could be. We won't be able to 
continue in this direction for much longer, so prepare yourself 
psychologically ;-) It's a bit ironic that all these needs for dynamic changes 
come mostly from the embedded world where everything was supposed to be 
static.

> >> Anyway that aside aside:
> >> 
> >> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > 
> > Thanks.

I've just noticed that the driver can crash due to .set_busid being still set 
to drm_platform_set_busid. I'll send a v2 with that removed and an explicit 
call to drm_dev_set_unique added. You might want to watch for the same issue 
if you review similar changes in other drivers.

> >>> +
> >>> +	if (ret < 0)
> >>> +		goto error;
> >>> +
> >>> +	DRM_INFO("Device %s probed\n", dev_name(&pdev->dev));
> >>>  	return 0;
> >>> +
> >>> +error:
> >>> +	rcar_du_remove(pdev);
> >>> +
> >>> +	return ret;
> >>>  }

-- 
Regards,

Laurent Pinchart

