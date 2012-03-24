From: Anton Vorontsov <anton.vorontsov@linaro.org>
Date: Sat, 24 Mar 2012 16:43:35 +0000
Subject: Re: [PATCH 07/10] um: Should hold tasklist_lock while traversing processes
Message-Id: <20120324164335.GA4955@lizard>
List-Id: <linux-sh.vger.kernel.org>
References: <20120324102609.GA28356@lizard> <20120324103030.GG29067@lizard>
 <1332593303.16159.28.camel@twins>
In-Reply-To: <1332593303.16159.28.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sat, Mar 24, 2012 at 01:48:23PM +0100, Peter Zijlstra wrote:
> On Sat, 2012-03-24 at 14:30 +0400, Anton Vorontsov wrote:
> > Traversing the tasks requires holding tasklist_lock, otherwise it
> > is unsafe. 
> 
> No it doesn't, it either requires tasklist_lock or rcu_read_lock().

Well, currently the code does neither. :-)

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
