From: Simon Horman <horms@verge.net.au>
Date: Wed, 17 Apr 2013 00:41:15 +0000
Subject: Re: [PATCH 19/26] sh: Don't use create_proc_read_entry() [RFC]
Message-Id: <20130417004115.GD16092@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130411132739.32763.82609.stgit@warthog.procyon.org.uk>
 <20130411133009.32763.71122.stgit@warthog.procyon.org.uk>
 <20130416061113.GA27462@verge.net.au>
 <20130416062842.GL4068@ZenIV.linux.org.uk>
 <20130416184203.GA18348@linux-sh.org>
In-Reply-To: <20130416184203.GA18348@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

On Wed, Apr 17, 2013 at 03:42:03AM +0900, Paul Mundt wrote:
> On Tue, Apr 16, 2013 at 07:28:42AM +0100, Al Viro wrote:
> > On Tue, Apr 16, 2013 at 03:11:13PM +0900, Simon Horman wrote:
> > > On Thu, Apr 11, 2013 at 02:30:09PM +0100, David Howells wrote:
> > > > Don't use create_proc_read_entry() as that is deprecated, but rather use
> > > > proc_create_data() and seq_file instead.
> > > 
> > > Paul, do you want me to handle this?
> > 
> > FWIW, I can pick that stuff via vfs.git - not a problem and I've already got
> > shitloads of procfs-related patches in that queue...
> 
> That works for me.

Great.

Acked-by: Simon Horman <horms+renesas@verge.net.au>

