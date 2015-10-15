From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 15 Oct 2015 07:16:50 +0000
Subject: Re: [PATCH/RFC] Simplify Gen3 DU and VSP Kconfig bits
Message-Id: <2093263.RpfqydBN8J@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20151015071120.11093.50169.sendpatchset@little-apple>
In-Reply-To: <20151015071120.11093.50169.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

Thank you for the patch.

On Thursday 15 October 2015 16:11:20 Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Simplify the R-Car DU configuration by removing various Kconfig entires.
> 
> Without this patch the DU driver has the following entries:
>  - CONFIG_DRM_RCAR_DU
>  - CONFIG_DRM_RCAR_HDMI
>  - CONFIG_DRM_RCAR_LVDS
>  - CONFIG_DRM_RCAR_VSP
> 
> With this patch the required entries are reduced to:
>  - CONFIG_DRM_RCAR_DU
> 
> This changes simplifies configuration but the downside is obviously
> larger run time size. We are however talking kilobytes in a world
> using gigabytes.

We've discussed this in the past and I was a bit dubious regarding the 
usefulness of such a simplification. I especially don't like including the VSP 
glue code unconditionally as it depends on a separate driver.

> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  Written against vsp1-kms-gen3-20150929
> 
>  drivers/gpu/drm/rcar-du/Kconfig           |   19 -----------------
>  drivers/gpu/drm/rcar-du/Makefile          |   12 ++++-------
>  drivers/gpu/drm/rcar-du/rcar_du_hdmicon.h |    8 -------
>  drivers/gpu/drm/rcar-du/rcar_du_hdmienc.h |    9 --------
>  drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.h |   16 --------------
>  drivers/gpu/drm/rcar-du/rcar_du_vsp.h     |    8 -------
>  include/media/vsp1.h                      |   31 ++++++++++++++++++++++++--
>  7 files changed, 34 insertions(+), 69 deletions(-)
> 
> --- 0001/drivers/gpu/drm/rcar-du/Kconfig
> +++ work/drivers/gpu/drm/rcar-du/Kconfig	2015-10-15 15:52:44.670513000 
+0900
> @@ -11,22 +11,3 @@ config DRM_RCAR_DU
>  	help
>  	  Choose this option if you have an R-Car chipset.
>  	  If M is selected the module will be called rcar-du-drm.
> -
> -config DRM_RCAR_HDMI
> -	bool "R-Car DU HDMI Encoder Support"
> -	depends on DRM_RCAR_DU
> -	help
> -	  Enable support for external HDMI encoders.
> -
> -config DRM_RCAR_LVDS
> -	bool "R-Car DU LVDS Encoder Support"
> -	depends on DRM_RCAR_DU
> -	help
> -	  Enable support for the R-Car Display Unit embedded LVDS encoders.
> -
> -config DRM_RCAR_VSP
> -	bool "R-Car DU VSP Compositor Support"
> -	depends on DRM_RCAR_DU
> -	depends on VIDEO_RENESAS_VSP1
> -	help
> -	  Enable support to expose the R-Car VSP Compositor as KMS planes.
> --- 0001/drivers/gpu/drm/rcar-du/Makefile
> +++ work/drivers/gpu/drm/rcar-du/Makefile	2015-10-15 15:53:07.890513000
> +0900 @@ -5,12 +5,10 @@ rcar-du-drm-y := rcar_du_crtc.o \
>  		 rcar_du_kms.o \
>  		 rcar_du_lvdscon.o \
>  		 rcar_du_plane.o \
> -		 rcar_du_vgacon.o
> -
> -rcar-du-drm-$(CONFIG_DRM_RCAR_HDMI)	+= rcar_du_hdmicon.o \
> -					   rcar_du_hdmienc.o
> -rcar-du-drm-$(CONFIG_DRM_RCAR_LVDS)	+= rcar_du_lvdsenc.o
> -
> -rcar-du-drm-$(CONFIG_DRM_RCAR_VSP)	+= rcar_du_vsp.o
> +		 rcar_du_vgacon.o \
> +		 rcar_du_hdmicon.o \
> +		 rcar_du_hdmienc.o \
> +		 rcar_du_vsp.o \
> +		 rcar_du_lvdsenc.o
> 
>  obj-$(CONFIG_DRM_RCAR_DU)		+= rcar-du-drm.o
> --- 0001/drivers/gpu/drm/rcar-du/rcar_du_hdmicon.h
> +++ work/drivers/gpu/drm/rcar-du/rcar_du_hdmicon.h	2015-10-15
> 15:51:36.950513000 +0900 @@ -17,15 +17,7 @@
>  struct rcar_du_device;
>  struct rcar_du_encoder;
> 
> -#if IS_ENABLED(CONFIG_DRM_RCAR_HDMI)
>  int rcar_du_hdmi_connector_init(struct rcar_du_device *rcdu,
>  				struct rcar_du_encoder *renc);
> -#else
> -static inline int rcar_du_hdmi_connector_init(struct rcar_du_device *rcdu,
> -					      struct rcar_du_encoder *renc)
> -{
> -	return -ENOSYS;
> -}
> -#endif
> 
>  #endif /* __RCAR_DU_HDMICON_H__ */
> --- 0001/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.h
> +++ work/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.h	2015-10-15
> 15:51:36.950513000 +0900 @@ -20,16 +20,7 @@ struct device_node;
>  struct rcar_du_device;
>  struct rcar_du_encoder;
> 
> -#if IS_ENABLED(CONFIG_DRM_RCAR_HDMI)
>  int rcar_du_hdmienc_init(struct rcar_du_device *rcdu,
>  			 struct rcar_du_encoder *renc, struct device_node *np);
> -#else
> -static inline int rcar_du_hdmienc_init(struct rcar_du_device *rcdu,
> -				       struct rcar_du_encoder *renc,
> -				       struct device_node *np)
> -{
> -	return -ENOSYS;
> -}
> -#endif
> 
>  #endif /* __RCAR_DU_HDMIENC_H__ */
> --- 0001/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.h
> +++ work/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.h	2015-10-15
> 15:54:28.790513000 +0900 @@ -26,26 +26,10 @@ enum rcar_lvds_input {
>  	RCAR_LVDS_INPUT_DU2,
>  };
> 
> -#if IS_ENABLED(CONFIG_DRM_RCAR_LVDS)
>  int rcar_du_lvdsenc_init(struct rcar_du_device *rcdu);
>  int rcar_du_lvdsenc_enable(struct rcar_du_lvdsenc *lvds,
>  			   struct drm_crtc *crtc, bool enable);
>  void rcar_du_lvdsenc_atomic_check(struct rcar_du_lvdsenc *lvds,
>  				  struct drm_display_mode *mode);
> -#else
> -static inline int rcar_du_lvdsenc_init(struct rcar_du_device *rcdu)
> -{
> -	return 0;
> -}
> -static inline int rcar_du_lvdsenc_enable(struct rcar_du_lvdsenc *lvds,
> -					 struct drm_crtc *crtc, bool enable)
> -{
> -	return 0;
> -}
> -static inline void rcar_du_lvdsenc_atomic_check(struct rcar_du_lvdsenc
> *lvds, -						struct drm_display_mode *mode)
> -{
> -}
> -#endif
> 
>  #endif /* __RCAR_DU_LVDSENC_H__ */
> --- 0001/drivers/gpu/drm/rcar-du/rcar_du_vsp.h
> +++ work/drivers/gpu/drm/rcar-du/rcar_du_vsp.h	2015-10-15 
15:55:22.190513000
> +0900 @@ -59,18 +59,10 @@ to_rcar_vsp_plane_state(struct drm_plane
>  	return container_of(state, struct rcar_du_vsp_plane_state, state);
>  }
> 
> -#ifdef CONFIG_DRM_RCAR_VSP
>  int rcar_du_vsp_init(struct rcar_du_vsp *vsp);
>  void rcar_du_vsp_enable(struct rcar_du_crtc *crtc);
>  void rcar_du_vsp_disable(struct rcar_du_crtc *crtc);
>  void rcar_du_vsp_atomic_begin(struct rcar_du_crtc *crtc);
>  void rcar_du_vsp_atomic_flush(struct rcar_du_crtc *crtc);
> -#else
> -static inline int rcar_du_vsp_init(struct rcar_du_vsp *vsp) { return 0; };
> -static inline void rcar_du_vsp_enable(struct rcar_du_crtc *crtc) { };
> -static inline void rcar_du_vsp_disable(struct rcar_du_crtc *crtc) { };
> -static inline void rcar_du_vsp_atomic_begin(struct rcar_du_crtc *crtc) { };
> -static inline void rcar_du_vsp_atomic_flush(struct rcar_du_crtc *crtc) {
> }; -#endif
> 
>  #endif /* __RCAR_DU_VSP_H__ */
> --- 0001/include/media/vsp1.h
> +++ work/include/media/vsp1.h	2015-10-15 16:00:51.170513000 +0900
> @@ -18,16 +18,43 @@
>  struct device;
>  struct v4l2_rect;
> 
> +#ifdef CONFIG_VIDEO_RENESAS_VSP1
>  int vsp1_du_init(struct device *dev);
> -
>  int vsp1_du_setup_lif(struct device *dev, unsigned int width,
>  		      unsigned int height);
> -
>  int vsp1_du_atomic_begin(struct device *dev);
>  int vsp1_du_atomic_update(struct device *dev, unsigned int rpf, u32
> pixelformat, unsigned int pitch, dma_addr_t mem[2],
>  			  const struct v4l2_rect *src,
>  			  const struct v4l2_rect *dst);
>  int vsp1_du_atomic_flush(struct device *dev);
> +#else
> +static inline int vsp1_du_init(struct device *dev)
> +{
> +	return -ENOSYS;
> +}
> +static inline int vsp1_du_setup_lif(struct device *dev, unsigned int width,
> +				    unsigned int height)
> +{
> +	return 0;
> +}
> +static inline int vsp1_du_atomic_begin(struct device *dev)
> +{
> +	return 0;
> +}
> +static inline int vsp1_du_atomic_update(struct device *dev, unsigned int
> rpf, +					u32 pixelformat,
> +					unsigned int pitch, dma_addr_t mem[2],
> +					const struct v4l2_rect *src,
> +					const struct v4l2_rect *dst)
> +{
> +	return 0;
> +}
> +static inline int vsp1_du_atomic_flush(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +#endif
> 
>  #endif /* __MEDIA_VSP1_H__ */

-- 
Regards,

Laurent Pinchart

