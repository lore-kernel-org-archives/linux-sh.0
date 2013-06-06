From: Chris Ball <cjb@laptop.org>
Date: Thu, 06 Jun 2013 15:48:55 +0000
Subject: Re: [PATCH v3 2/2] mmc: tmio: reset the controller after power-up
Message-Id: <871u8f6xzs.fsf@octavius.laptop.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1304230916270.1422@axis700.grange>
	<871u8f8nxb.fsf@octavius.laptop.org>
	<Pine.LNX.4.64.1306061625290.32566@axis700.grange>
	<Pine.LNX.4.64.1306061626200.32566@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1306061626200.32566@axis700.grange> (Guennadi
	Liakhovetski's message of "Thu, 6 Jun 2013 16:35:48 +0200 (CEST)")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org

Hi,

On Thu, Jun 06 2013, Guennadi Liakhovetski wrote:
> This fixes two reported problems:
> 1. after a system resume the controller isn't functioning until a command
>    runs on a timeout and a controller reset is performed.
> 2. if a card is ejected during a running write operation, its re-insertion
>    isn't detected.
>
> Reported-by: Nguyen Viet Dung <nv-dung@jinso.co.jp>
> Reported-by: Nguyen Hong Ky <nh-ky@jinso.co.jp>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> Tested-by: Nguyen Viet Dung <nv-dung@jinso.co.jp>
> Tested-by: Nguyen Hong Ky <nh-ky@jinso.co.jp>
> ---
>
> v3: rebased on top of current mmc-next / 3.10-rc

Thanks, pushed to mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
