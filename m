From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 16 Mar 2009 11:05:02 +0000
Subject: Re: [Proposal][PATCH] sh: PMB hibernation support
Message-Id: <20090316110502.GD21433@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <49B794C6.8000806@st.com>
In-Reply-To: <49B794C6.8000806@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 11, 2009 at 11:39:02AM +0100, Francesco VIRLINZI wrote:
> In attach there is a proposal on how manage the PMB after a resume from 
> hibernation.
> My assumption in background is that "just because the kernel runs.. the 
> "core" PMB (main memory) are already ok"
> In our kernel I'm doing something very similar.
> I can say: it compiles but I have no way to really test this code as it is.
> 
This looks like as good a place as any to start, so I'll merge this for
now, and we can build on top of this incrementally as other cases pop up.
