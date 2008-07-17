From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 17 Jul 2008 23:09:39 +0000
Subject: Re: [PATCH] sh: Don't miss pending signals returning to user mode after signal processing
Message-Id: <20080717230939.GC17674@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <487F3648.8040005@st.com>
In-Reply-To: <487F3648.8040005@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jul 17, 2008 at 01:08:40PM +0100, Stuart MENEFY wrote:
> sh: Don't miss pending signals returning to user mode after signal 
> processing
> 
> Without this patch, signals sent during architecture specific signal
> handling (typically as a result of the user's stack being inaccessible)
> are ignored.
> 
> This is the SH version of commit c3ff8ec31c1249d268cd11390649768a12bec1b9
> which was for the i386.
> 
> Signed-off-by: Stuart Menefy <stuart.menefy@st.com>

Applied, thanks Stuart.
