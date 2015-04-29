From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 29 Apr 2015 11:33:31 +0000
Subject: Re: [PATCH 01/10] drm: rcar-du: Document the rcar_du_crtc structure
Message-Id: <5540C18B.4080104@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1430267884-20560-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1430267884-20560-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1430267884-20560-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

Hello.

On 4/29/2015 3:37 AM, Laurent Pinchart wrote:

> Document the structure fields using kerneldoc.

> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>   drivers/gpu/drm/rcar-du/rcar_du_crtc.h | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.h b/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
> index 5d9aa9b33769..e72f15c8c706 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
> @@ -22,6 +22,20 @@
>
>   struct rcar_du_group;
>
> +/*

    Kerneldoc needs /** at the start of comment.

> + * rcar_du_crtc - the CRTC, representing a DU superposition processor

    Kerneldoc needs *struct* before the name.

[...]

WBR, Sergei

