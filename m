From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Date: Thu, 13 May 2010 18:02:27 +0000
Subject: Re: tcdrain problem
Message-Id: <4BEC3EB3.4040906@gandalf.sssup.it>
List-Id: <linux-sh.vger.kernel.org>
References: <97289aa96d3e9aa9ca63f8dc206c36d8.squirrel@www.aurion-tech.com>
In-Reply-To: <97289aa96d3e9aa9ca63f8dc206c36d8.squirrel@www.aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Fabio Giovagnini wrote:
> Hi all, is it possible tcdrain doesn't wait the trasmission on ttySCI1?
> There a way to open the open the port so that it has to work?
> DO I need to set some attributes?
>   
I have propesed a patch for the drain but I think that now it's present 
in the newest kernel
you can check the mailing list and find.

Michael Trimarchi
> Thanks a lot
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>   

