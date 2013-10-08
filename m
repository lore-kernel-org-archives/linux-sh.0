From: Simon Horman <horms@verge.net.au>
Date: Tue, 08 Oct 2013 01:50:08 +0000
Subject: Re: [PATCH 4/4] ARM: shmobile: r8a7779: add I2C clock for DT
Message-Id: <20131008015006.GB16625@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1352277298-23312-5-git-send-email-horms@verge.net.au>
In-Reply-To: <1352277298-23312-5-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Oct 03, 2013 at 11:45:03PM -0700, Kuninori Morimoto wrote:
> 10e8d4f6dddb0f9dc408c2f2bde8399b243a42ca
> (ARM: mach-shmobile: r8a7779: Minimal setup using DT)
> added I2C driver for DT, but it didn't add clock.
> This patch adds missing clock for I2C
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, I have queued this up but I am unsure if it will
end up in v3.13 or v3.14.
