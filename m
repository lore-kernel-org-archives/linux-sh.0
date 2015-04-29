From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 29 Apr 2015 11:34:21 +0000
Subject: Re: [PATCH 02/10] drm: rcar-du: Document the rcar_du_plane_state structure
Message-Id: <5540C1BD.4010608@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1430267884-20560-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1430267884-20560-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1430267884-20560-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

On 4/29/2015 3:37 AM, Laurent Pinchart wrote:

> Document the structure fields using kerneldoc.

> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>   drivers/gpu/drm/rcar-du/rcar_du_plane.h | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)

> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.h b/drivers/gpu/drm/rcar-du/rcar_du_plane.h
> index abff0ebeb195..5d2b764919d8 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_plane.h
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.h
> @@ -46,11 +46,20 @@ struct rcar_du_planes {
>   	struct drm_property *zpos;
>   };
>
> +/*
> + * rcar_du_plane_state - Driver-specific plane state

    Same comments as for the previous patch.

[...]

WBR, Sergei

