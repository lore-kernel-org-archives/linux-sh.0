From: Greg KH <gregkh@linuxfoundation.org>
Date: Fri, 09 Mar 2012 17:10:07 +0000
Subject: Re: [PATCH 3/7] serial: sh-sci: restore big-endian operation.
Message-Id: <20120309171007.GA25965@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1331311133-26937-1-git-send-email-thomas@codesourcery.com>
 <1331311133-26937-3-git-send-email-thomas@codesourcery.com>
In-Reply-To: <1331311133-26937-3-git-send-email-thomas@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Schwinge <thomas@codesourcery.com>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, linux-serial@vger.kernel.org

On Fri, Mar 09, 2012 at 05:38:49PM +0100, Thomas Schwinge wrote:
> As of 37b7a97884ba64bf7d403351ac2a9476ab4f1bba we have to use the
> endianess-agnostic I/O accessor functions.

Please always put a human readable description of what the git id is, so
that we have a chance to understand what is going on.

Are these patches supposed to be going through the sh tree, or the
serial tree to Linus?

And watch your To: line, it seemed to be munged :(

confused,

greg k-h
