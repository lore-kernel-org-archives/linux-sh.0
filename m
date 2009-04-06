From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 06 Apr 2009 15:58:31 +0000
Subject: Re: [PATCH] Added resume from hibernation support to the intc
Message-Id: <20090406155831.GD17834@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <49D9AC70.3040001@st.com>
In-Reply-To: <49D9AC70.3040001@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Apr 06, 2009 at 09:17:04AM +0200, Francesco VIRLINZI wrote:
> 

> From 9d6047a32ebd72af6abae5ae2d6e7ea5e2447c25 Mon Sep 17 00:00:00 2001
> From: Francesco Virlinzi <francesco.virlinzi@st.com>
> Date: Mon, 6 Apr 2009 09:09:39 +0200
> Subject: [PATCH] sh_intc: Added resume from hibernation support to the intc
> 
> It's required for all modules loaded in the previous runtime
> session because not initilized duing the kernel start-up.
> 
> Signed-off-by: Francesco Virlinzi <francesco.virlinzi@st.com>

Applied, thanks.
