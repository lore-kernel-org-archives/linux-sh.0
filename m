From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 14 Sep 2009 05:54:50 +0000
Subject: Re: What's in sh-2.6.git for 2.6.32?
Message-Id: <20090914055450.GG15078@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090914054854.GF15078@linux-sh.org>
In-Reply-To: <20090914054854.GF15078@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Sep 14, 2009 at 02:48:54PM +0900, Paul Mundt wrote:
>  drivers/block/aoe/aoe.h                            |    2 +-
>  drivers/block/aoe/aoeblk.c                         |   12 +-
>  drivers/block/aoe/aoedev.c                         |    1 -
>  drivers/gpu/drm/i915/i915_gem.c                    |    6 +-
>  drivers/gpu/drm/i915/intel_dp.c                    |    2 +-
>  drivers/gpu/drm/i915/intel_drv.h                   |    1 -
>  drivers/gpu/drm/i915/intel_tv.c                    |    1 -

These obviously are just a result of the suspend tree being a couple of
changes ahead which I failed to account for, so just pretend these don't
exist.
