From: Hans Verkuil <hverkuil@xs4all.nl>
Date: Tue, 24 Jun 2014 10:25:09 +0000
Subject: Re: [PATCH v2 05/23] v4l: vb2: Fix stream start and buffer completion race
Message-Id: <53A95205.8000004@xs4all.nl>
List-Id: <linux-sh.vger.kernel.org>
References: <1403567669-18539-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1403567669-18539-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1403567669-18539-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org

On 06/24/14 01:54, Laurent Pinchart wrote:
> videobuf2 stores the driver streaming state internally in the queue in
> the start_streaming_called variable. The state is set right after the
> driver start_stream operation returns, and checked in the
> vb2_buffer_done() function, typically called from the frame completion
> interrupt handler. A race condition exists if the hardware finishes
> processing the first frame before the start_stream operation returns.
> 
> Fix this by setting start_streaming_called to 1 before calling the
> start_stream operation, and resetting it to 0 if the operation fails.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Reviewed-by: Hans Verkuil <hans.verkuil@cisco.com>

Good catch!

This needs a:

Cc: stable@vger.kernel.org      # for v3.15 and up

Regards,

	Hans

> ---
>  drivers/media/v4l2-core/videobuf2-core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/v4l2-core/videobuf2-core.c b/drivers/media/v4l2-core/videobuf2-core.c
> index 7c4489c..1d67e95 100644
> --- a/drivers/media/v4l2-core/videobuf2-core.c
> +++ b/drivers/media/v4l2-core/videobuf2-core.c
> @@ -1750,12 +1750,14 @@ static int vb2_start_streaming(struct vb2_queue *q)
>  		__enqueue_in_driver(vb);
>  
>  	/* Tell the driver to start streaming */
> +	q->start_streaming_called = 1;
>  	ret = call_qop(q, start_streaming, q,
>  		       atomic_read(&q->owned_by_drv_count));
> -	q->start_streaming_called = ret = 0;
>  	if (!ret)
>  		return 0;
>  
> +	q->start_streaming_called = 0;
> +
>  	dprintk(1, "driver refused to start streaming\n");
>  	if (WARN_ON(atomic_read(&q->owned_by_drv_count))) {
>  		unsigned i;
> 

