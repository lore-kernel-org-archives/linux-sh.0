From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 22 Dec 2014 09:27:35 +0000
Subject: Re: [PATCH 0/2] Add VSP1 devices to DT for r8a7790 and r8a7791
Message-Id: <1749192.EjGsnkTb20@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1410651385-13090-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1410651385-13090-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sakari,

On Saturday 20 December 2014 23:46:00 Sakari Ailus wrote:
> On Sat, Dec 20, 2014 at 09:00:11PM +0200, Laurent Pinchart wrote:
> > On Friday 19 December 2014 05:05:22 Devendra Talegaonkar wrote:
> > > Hi,
> > > Thanks for the reply. I could successfully stream file data to display
> > > via media link. Now on Lager board, I am trying to stream live video
> > > data captured from camera ( VIN1 input via ADV7180 decoder, RGB565 )  to
> > > display. I am using yavta to capture data from camera and streaming it
> > > to rpf.0. But I am not able to see data on VGA. I am using following
> > > commands to establish media link ./vsp1.sh media1 m2d ARGB565 ARGB32
> > > Then yavta to capture and stream data with following command:
> > > "./yavta -c -n 4 -f RGB565 -s 400x200 /dev/video1 /dev/video10" (
> > > video10
> > > being associated dev for rpf.0) modetest command as follows:
> > > "./modetest -M rcar-du -s 17@11:1024x768@AR24 -d -P
> > > '11@32:1024x768@XR24"
> > > 
> > > Am I missing something or doing something wrong?
> > 
> > Yes. Or actually yavta is missing something :-) yavta is able to capture
> > from a video node to file, or output the contents of a file to a video
> > node, but doesn't have the ability to capture from one video node and
> > feed the frames to another video node.
> > 
> > That would be an interesting addition to yavta though as it would allow
> > exercising the dmabuf code paths, but I wonder whether it would really fit
> > in yavta's original purpose as a low-level V4L2 test tool.
> > 
> > Sakari, you're somehow familiar with the code base, what would you think ?
> 
> I propose to implement reading from and writing to a given file handle (or
> just stdin/stdout). I don't think we currently have them at the moment, but
> it'd fit well for yavta IMHO. This way you could pipe the data from one
> yavta instance to another.
> 
> This is how I tested m2m devices using yavta; it takes the device file
> handle as a parameter (--fd option) instead of opening it.

That won't help much here as the goal is to share buffers between two video 
nodes using dmabuf.

Following our private discussion I think one solution would be to pass buffers 
between two yavta instances using unix sockets. Defining a protocol would be 
needed. Oh, and implementing it in yavta of course :-)

-- 
Regards,

Laurent Pinchart

