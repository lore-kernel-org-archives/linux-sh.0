From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 11 Sep 2008 05:59:15 +0000
Subject: Re: [PATCH] sh_eth: unsigned ndev->irq cannot be negative
Message-Id: <20080911055915.GA1184@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <48C80264.2070205@gmail.com>
In-Reply-To: <48C80264.2070205@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Sep 10, 2008 at 07:22:44PM +0200, roel kluin wrote:
> unsigned ndev->irq cannot be negative
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>

On Wed, Sep 10, 2008 at 07:34:44PM +0200, roel kluin wrote:
> possibly since commit b420b1a7a17ea88531d0e12b2f2679a0c8365803
> ---
> rtc-sh: Unsigned rtc->{periodic,carry,alarm}_irq cannot be negative
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>

Applied, thanks.
