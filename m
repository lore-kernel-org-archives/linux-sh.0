From: Alessandro Zummo <alessandro.zummo@towertech.it>
Date: Wed, 06 Aug 2008 18:00:57 +0000
Subject: Re: [PATCH 2/2] rtc: rtc-rs5c372: add support for Ricoh R2025S/D
Message-Id: <20080806200057.6eeca72c@i1501.lan.towertech.it>
List-Id: <linux-sh.vger.kernel.org>
References: <20080806110008.GA5477@linux-sh.org>
In-Reply-To: <20080806110008.GA5477@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, 6 Aug 2008 20:00:08 +0900
Paul Mundt <lethal@linux-sh.org> wrote:

> This adds support for the Ricoh R2025S/D series of I2C RTCs, produced
> by Ricoh Japan and described at:
> 
> 	http://www.ricoh.co.jp/LSI/product_rtc/2wire/r2025x/
> 
> This series has very minor deviations from the rest of the RS5C chips, most of
> which have to do with the oscillator, which was abstracted away in an earlier
> patch.
> 
> Signed-off-by: Paul Mundt <lethal@linux-sh.org>
> Acked-by: David Brownell <david-b@pacbell.net>
> Tested-by: Riku Voipio <riku.voipio@movial.fi>

 Acked-by: Alessandro Zummo <a.zummo@towertech.it>


-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it

