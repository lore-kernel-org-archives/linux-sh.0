From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 26 Sep 2008 01:00:02 +0000
Subject: Re: MFD for hd64461 thoughts and ideas
Message-Id: <20080926010002.GB14257@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080925221814.51b06ed2.kristoffer.ericson@gmail.com>
In-Reply-To: <20080925221814.51b06ed2.kristoffer.ericson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Sep 26, 2008 at 09:56:39AM +0900, Paul Mundt wrote:
> resource size is off by 1. Should be res->end - res->start - 1. Better
> yet, use the shiny new resource_len() interface that handles this for
> you, so I don't have to make a macro that repeats this sentence every
> time someone posts a driver to the list. ;-)
> 
And by - 1 I obviously mean + 1. Yet another reason to use
resource_len(), it fails at typing less than I do.
