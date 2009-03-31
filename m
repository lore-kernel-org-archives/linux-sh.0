From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 31 Mar 2009 05:33:49 +0000
Subject: Re: [PATCH 2/2] Add support ov772x driver setting to ap325
Message-Id: <20090331053349.GA31415@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <uhc3skvqd.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uhc3skvqd.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Mar 31, 2009 at 02:34:21PM +0900, morimoto.kuninori@renesas.com wrote:
> 
> Dear Paul
> 
> > > This patch add ov772x camera settings to ap325,
> > > Old camera is still supported. And it will be 2nd camera
> > > if you select ov772x and soc_camera_platform in same time.
> > > 
> > > Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> > > Signed-off-by: Magnus Damm <damm@igel.co.jp>
> > 
> > This is now re-added to the queue, as the V4L merge has taken place now.
> > Please make sure everything works as it is supposed to.
> 
> Thank you
> 
> But please apply folloing patch also.
> 
> 2009/03/11
> [PATCH] sh: ap325 and Migo-R use new sh_mobile_ceu_info flags
> 
Applied also, thanks.
