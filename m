From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 25 Oct 2010 01:58:35 +0000
Subject: Re: [PATCH] sh: i2c-sh7760: Replase from ctrl_* to __raw_*
Message-Id: <20101025015835.GE2173@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1287785220-5893-1-git-send-email-iwamatsu@nigauri.org>
In-Reply-To: <1287785220-5893-1-git-send-email-iwamatsu@nigauri.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org

On Sat, Oct 23, 2010 at 07:07:00AM +0900, Nobuhiro Iwamatsu wrote:
> ctrl_* is deprecated. We should to use __raw_*.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

Applied, thanks.
