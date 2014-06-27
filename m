From: Hans Verkuil <hverkuil@xs4all.nl>
Date: Fri, 27 Jun 2014 09:34:20 +0000
Subject: Re: [PATCH v2 02/23] DocBook: media: Document ALPHA_COMPONENT control usage on output devices
Message-Id: <53AD3A9C.3070404@xs4all.nl>
List-Id: <linux-sh.vger.kernel.org>
References: <1403567669-18539-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1403567669-18539-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1403567669-18539-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Acked-by: Hans Verkuil <hans.verkuil@cisco.com>

Regards,

	Hans

On 06/24/2014 01:54 AM, Laurent Pinchart wrote:
> Extend the V4L2_CID_ALPHA_COMPONENT control for use on output devices,
> to set the alpha component value when the output format doesn't have an
> alpha channel.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>   Documentation/DocBook/media/v4l/controls.xml | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/DocBook/media/v4l/controls.xml b/Documentation/DocBook/media/v4l/controls.xml
> index 47198ee..4dfea27 100644
> --- a/Documentation/DocBook/media/v4l/controls.xml
> +++ b/Documentation/DocBook/media/v4l/controls.xml
> @@ -398,14 +398,17 @@ to work.</entry>
>   	  <row id="v4l2-alpha-component">
>   	    <entry><constant>V4L2_CID_ALPHA_COMPONENT</constant></entry>
>   	    <entry>integer</entry>
> -	    <entry> Sets the alpha color component on the capture device or on
> -	    the capture buffer queue of a mem-to-mem device. When a mem-to-mem
> -	    device produces frame format that includes an alpha component
> +	    <entry>Sets the alpha color component. When a capture device (or
> +	    capture queue of a mem-to-mem device) produces a frame format that
> +	    includes an alpha component
>   	    (e.g. <link linkend="rgb-formats">packed RGB image formats</link>)
> -	    and the alpha value is not defined by the mem-to-mem input data
> -	    this control lets you select the alpha component value of all
> -	    pixels. It is applicable to any pixel format that contains an alpha
> -	    component.
> +	    and the alpha value is not defined by the device or the mem-to-mem
> +	    input data this control lets you select the alpha component value of
> +	    all pixels. When an output device (or output queue of a mem-to-mem
> +	    device) consumes a frame format that doesn't include an alpha
> +	    component and the device supports alpha channel processing this
> +	    control lets you set the alpha component value of all pixels for
> +	    further processing in the device.
>   	    </entry>
>   	  </row>
>   	  <row>
>
