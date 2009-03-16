From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 16 Mar 2009 11:11:25 +0000
Subject: Re: [PATCH] sh-clkfwk  Safer resume from hibenration
Message-Id: <20090316111125.GE21433@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <49BA1461.7070207@st.com>
In-Reply-To: <49BA1461.7070207@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Mar 16, 2009 at 06:14:14AM +0100, Francesco VIRLINZI wrote:
> This patch fixes a possible problem in the resume from
> hibenration. It temporaneally saves the clk->rate on the
> stack to avoid any possible change during the clk->set_parent(..)
> call
> 
Applied, thanks.
