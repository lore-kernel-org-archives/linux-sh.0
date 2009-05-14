From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 14 May 2009 03:42:27 +0000
Subject: Re: [PATCH] sh: clkfw: Added the .set_rate_ex callback in the clock operation [v2]
Message-Id: <20090514034226.GB10956@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1242058812-18864-1-git-send-email-francesco.virlinzi@st.com>
In-Reply-To: <1242058812-18864-1-git-send-email-francesco.virlinzi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, May 11, 2009 at 06:34:13PM +0200, Francesco VIRLINZI wrote:
> This patch adds the .set_rate_ex callback to manage clearly the
> clk_set_rate() operation and the operation under clk_set_rate_ex().
> 
No. If you don't need to use algo_id, then just ignore it. We are not
going to have two different clock ops that do exactly the same thing
because you don't like the extra argument.
