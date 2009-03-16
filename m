From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 16 Mar 2009 11:13:14 +0000
Subject: Re: [PATCH] sh: clkfwk: Changed the init function
Message-Id: <20090316111314.GG21433@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <49BA1505.7000500@st.com>
In-Reply-To: <49BA1505.7000500@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 13, 2009 at 09:10:45AM +0100, Francesco VIRLINZI wrote:
> This patch changes the init field in the clk_ops structure.
> Moreover it changes how the init function is used.
> Now it's called during registration and if something was wrong the clock 
> isn't registered.
> 
Ok, I'll bite. Why?
