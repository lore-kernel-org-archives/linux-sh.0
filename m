From: Simon Horman <horms@verge.net.au>
Date: Mon, 06 Jan 2014 06:45:16 +0000
Subject: Re: [PATCH V3 2/2] ARM: shmobile: lager: Add VIN1 SoC camera support
Message-Id: <20140106064516.GJ24653@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Dec 27, 2013 at 03:44:04PM +0400, Valentine Barshak wrote:
> This adds VIN1 SoC camera along with ADV7180 subdevice support to Lager.
> VIN0 camera is not registered because it has ADV7612 I2C subdevice
> which is not supported yet.
> 
> Changes in V2:
> * made lager_add_vin_device function static.
> 
> Changes in V3:
> * capitalized ARM in the subject.
> 
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>

Thanks, I will queue this up.
