From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 07 Jan 2010 23:03:21 +0000
Subject: Re: [PATCH 1/3] sh: prepare the DMA driver for slave functionality
Message-Id: <4B466839.8010601@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1001061538360.4366@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1001061538360.4366@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Guennadi Liakhovetski wrote:
> Slightly clean up and prepare for slave DMA the shdma driver.

Please add some notes about the why/what of factoring out 
sh_dmae_prep_sg() and sh_dmae_add_desc() .  Reading this changelog I was 
expecting primarily simple cleanups, with maybe a few function renames.

Otherwise looks ok to me.

--
Dan

