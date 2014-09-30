From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 30 Sep 2014 22:56:56 +0000
Subject: Re: [PATCH 0/2] Add VSP1 devices to DT for r8a7790 and r8a7791
Message-Id: <1734725.HHrFxhR7bF@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart5099964.VZ2GqrLglz"
List-Id: <linux-sh.vger.kernel.org>
References: <1410651385-13090-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1410651385-13090-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart5099964.VZ2GqrLglz
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Cao Minh,

On Tuesday 30 September 2014 13:47:32 Cao Minh Hiep wrote:
> Hi Laurent,
> 
> We are testing the upstream linux version on Lager.
> I have tried to test VSP1 driver on r8a7790(Lager).
> But I don't know how to test it.
> Could you please tell the method to test it?

Sure.

I've attached the test script I use to configure the VSP1 pipeline to this e-
mail.

Syntax: vsp1.sh dev cmd [...]

Supported commands:
 - m2d | m2d-bru | m2d-crop | m2d-scale | m2m | m2m-crop | m2m-scale infmt 
outfmt
 - input index infmt
 - output index outfmt

"dev" should be the media device name without the /dev/ prefix. For the first 
VSP1 that would thus be "media0".

"cmd" is one of the values listed above. m2d stands for memory to display 
(using out of tree patches for the DRM driver) and m2m stands for memory to 
memory. The *-bru command configures the BRU to blend two inputs, the *-crop 
commands will perform cropping on the input and the -scale commands will 
include the scaler (UDS) in the pipeline.

All the m2d and m2m commands perform pipeline configuration. They take two 
arguments, the input format and the output format. They should both be one of 
BGR24, BGR32, ABGR32, XBGR32, RGB24, RGB32, ARGB32, XRGB32, RGB332, RGB555, 
RGB565, NV12M, NV16M, NV21M, NV61M, UYVY, VYUY, YUV420M, YUYV or YVYU.

The input and output commands will invoke yavta to capture images from a WPF 
(output) or stream images to an RPF (input). You can find a tarball with the 
test frames I use at http://www.ideasonboard.org/frame-reference.tar.bz2, but 
you can replace them with any binary test image.

The script requires the media-ctl and yavta utilities. The former is now part 
of the v4l-utils project, available at http://git.linuxtv.org/cgit.cgi/v4l-utils.git/. The latter can be found at http://git.ideasonboard.org/yavta.git.

I realize this probably lacks details, so please come back with any question 
you might have and I'll do my best to answer them.

-- 
Regards,

Laurent Pinchart

--nextPart5099964.VZ2GqrLglz
Content-Disposition: attachment; filename="vsp1.sh"
Content-Transfer-Encoding: 7Bit
Content-Type: application/x-shellscript; name="vsp1.sh"

#!/bin/sh

# ------------------------------------------------------------------------------
# Pipeline configuration
#

pipe_m2d() {
	./media-ctl -d $mdev -r
	./media-ctl -d $mdev -l "'$dev rpf.0':1 -> '$dev wpf.0':0 [1]"
	./media-ctl -d $mdev -l "'$dev wpf.0':1 -> '$dev lif':0 [1]"
}

pipe_m2d_bru() {
	./media-ctl -d $mdev -r
	./media-ctl -d $mdev -l "'$dev rpf.0':1 -> '$dev uds.0':0 [1]"
	./media-ctl -d $mdev -l "'$dev uds.0':1 -> '$dev bru':0 [1]"
	./media-ctl -d $mdev -l "'$dev rpf.1':1 -> '$dev bru':1 [1]"
	./media-ctl -d $mdev -l "'$dev bru':4 -> '$dev wpf.0':0 [1]"
	./media-ctl -d $mdev -l "'$dev wpf.0':1 -> '$dev lif':0 [1]"
}

pipe_m2d_scale() {
	./media-ctl -d $mdev -r
	./media-ctl -d $mdev -l "'$dev rpf.0':1 -> '$dev uds.0':0 [1]"
	./media-ctl -d $mdev -l "'$dev uds.0':1 -> '$dev wpf.0':0 [1]"
	./media-ctl -d $mdev -l "'$dev wpf.0':1 -> '$dev lif':0 [1]"
}

pipe_m2m() {
	./media-ctl -d $mdev -r
	./media-ctl -d $mdev -l "'$dev rpf.0':1 -> '$dev wpf.0':0 [1]"
	./media-ctl -d $mdev -l "'$dev wpf.0':1 -> '$dev wpf.0 output':0 [1]"
}

pipe_m2m_bru() {
	./media-ctl -d $mdev -r
	./media-ctl -d $mdev -l "'$dev rpf.0':1 -> '$dev uds.0':0 [1]"
	./media-ctl -d $mdev -l "'$dev uds.0':1 -> '$dev bru':0 [1]"
	./media-ctl -d $mdev -l "'$dev rpf.1':1 -> '$dev bru':1 [1]"
	./media-ctl -d $mdev -l "'$dev bru':4 -> '$dev wpf.0':0 [1]"
	./media-ctl -d $mdev -l "'$dev wpf.0':1 -> '$dev wpf.0 output':0 [1]"
}

pipe_m2m_scale() {
	./media-ctl -d $mdev -r
	./media-ctl -d $mdev -l "'$dev rpf.0':1 -> '$dev uds.0':0 [1]"
	./media-ctl -d $mdev -l "'$dev uds.0':1 -> '$dev wpf.0':0 [1]"
	./media-ctl -d $mdev -l "'$dev wpf.0':1 -> '$dev wpf.0 output':0 [1]"
}

pipe_format() {
	case $1 in
	BGR24 | BGR32 | ABGR32 | XBGR32 | RGB24 | RGB32 | ARGB32 | XRGB32 | RGB332 | RGB555 | RGB565)
		echo "ARGB32";
		;;

	NV12M | NV16M | NV21M | NV61M | UYVY | VYUY | YUV420M | YUYV | YVYU)
		echo "AYUV32"
		;;

	*)
		echo "Invalid format $1"
		exit 1
	esac
}

# ------------------------------------------------------------------------------
# Format retrieval
#

video_get_size() {
	size=`./media-ctl -d $mdev --get-v4l2 "'$dev $1':$2" | grep fmt | \
	      sed 's/.*\/\([0-9x]*\).*/\1/'`
}

# ------------------------------------------------------------------------------
# Parse the command line and retrieve the formats
#

syntax() {
	echo "Syntax: vsp1.sh dev cmd [...]"
	echo ""
	echo "Supported commands:"
	echo " - m2d | m2d-bru | m2d-crop | m2d-scale infmt outfmt"
	echo " - m2m | m2m-bru | m2m-crop | m2m-scale infmt outfmt"
	echo " - input index infmt [options]"
	echo " - output index outfmt [options]"
}

mdev=/dev/$1
dev=`./media-ctl -d $mdev -p | grep 'bus info' | sed 's/.*platform://'`

if [ -z $dev ] ; then
	echo "Error: Device $dev doesn't exist"
	syntax
	exit 1
fi

cmd=$2

case $cmd in
m2d | m2d-bru | m2d-crop | m2d-scale | m2m | m2m-bru | m2m-crop | m2m-scale)
	if [ $# != 4 ] ; then
		syntax
		exit 1
	fi
	infmt=$3
	outfmt=$4
	;;

input)
	index=$3
	infmt=$4
	options=$5
	;;

output)
	index=$3
	outfmt=$4
	options=$5
	;;

*)
	echo "Invalid command $cmd"
	;;
esac

# ------------------------------------------------------------------------------
# Execute the command
#

case $cmd in
m2d)
	pipe_m2d

	infmt=$(pipe_format $infmt)
	outfmt=$(pipe_format $outfmt)

	./media-ctl -d $mdev -V "'$dev rpf.0':0 [fmt:$infmt/640x480]"
	./media-ctl -d $mdev -V "'$dev wpf.0':0 [fmt:$infmt/640x480]"
	./media-ctl -d $mdev -V "'$dev wpf.0':1 [fmt:$outfmt/640x480]"
	./media-ctl -d $mdev -V "'$dev lif':0   [fmt:$outfmt/640x480]"
	;;

m2d-bru)
	pipe_m2d_bru

	infmt=$(pipe_format $infmt)
	outfmt=$(pipe_format $outfmt)

	./media-ctl -d $mdev -V "'$dev rpf.0':0 [fmt:$infmt/1024x768]"
	./media-ctl -d $mdev -V "'$dev uds.0':0 [fmt:$infmt/1024x768]"
	./media-ctl -d $mdev -V "'$dev uds.0':1 [fmt:$infmt/640x480]"
	./media-ctl -d $mdev -V "'$dev rpf.1':0 [fmt:$infmt/640x480]"
	./media-ctl -d $mdev -V "'$dev bru':0 [fmt:$infmt/640x480 compose:(50,50)/640x400]"
	./media-ctl -d $mdev -V "'$dev bru':1 [fmt:$infmt/640x480 compose:(100,100)/640x400]"
	./media-ctl -d $mdev -V "'$dev bru':4 [fmt:$infmt/640x480]"
	./media-ctl -d $mdev -V "'$dev wpf.0':0 [fmt:$infmt/640x480]"
	./media-ctl -d $mdev -V "'$dev wpf.0':1 [fmt:$outfmt/640x480]"
	./media-ctl -d $mdev -V "'$dev lif':0 [fmt:$outfmt/640x480]"
	;;

m2d-crop)
	pipe_m2d

	infmt=$(pipe_format $infmt)
	outfmt=$(pipe_format $outfmt)

	./media-ctl -d $mdev -V "'$dev rpf.0':0 [fmt:$infmt/1024x768 crop:(100,0)/640x480]"
	./media-ctl -d $mdev -V "'$dev wpf.0':0 [fmt:$infmt/640x480]"
	./media-ctl -d $mdev -V "'$dev wpf.0':1 [fmt:$outfmt/640x480]"
	./media-ctl -d $mdev -V "'$dev lif':0   [fmt:$outfmt/640x480]"
	;;

m2d-scale)
	pipe_m2d_scale

	infmt=$(pipe_format $infmt)
	outfmt=$(pipe_format $outfmt)

	./media-ctl -d $mdev -V "'$dev rpf.0':0 [fmt:$infmt/1024x768]"
	./media-ctl -d $mdev -V "'$dev uds.0':0 [fmt:$infmt/1024x768]"
	./media-ctl -d $mdev -V "'$dev uds.0':1 [fmt:$infmt/640x480]"
	./media-ctl -d $mdev -V "'$dev wpf.0':0 [fmt:$infmt/640x480]"
	./media-ctl -d $mdev -V "'$dev wpf.0':1 [fmt:$outfmt/640x480]"
	./media-ctl -d $mdev -V "'$dev lif':0   [fmt:$outfmt/640x480]"
	;;

m2m)
	pipe_m2m

	infmt=$(pipe_format $infmt)
	outfmt=$(pipe_format $outfmt)

	./media-ctl -d $mdev -V "'$dev rpf.0':0 [fmt:$infmt/1024x768]"
	./media-ctl -d $mdev -V "'$dev wpf.0':0 [fmt:$infmt/1024x768]"
	./media-ctl -d $mdev -V "'$dev wpf.0':1 [fmt:$outfmt/1024x768]"
	;;

m2m-bru)
	pipe_m2m_bru

	infmt=$(pipe_format $infmt)
	outfmt=$(pipe_format $outfmt)

	./media-ctl -d $mdev -V "'$dev rpf.0':0 [fmt:$infmt/1024x768]"
	./media-ctl -d $mdev -V "'$dev uds.0':0 [fmt:$infmt/1024x768]"
	./media-ctl -d $mdev -V "'$dev uds.0':1 [fmt:$infmt/640x480]"
	./media-ctl -d $mdev -V "'$dev rpf.1':0 [fmt:$infmt/640x480]"
	./media-ctl -d $mdev -V "'$dev bru':0 [fmt:$infmt/640x480 compose:(50,50)/640x400]"
	./media-ctl -d $mdev -V "'$dev bru':1 [fmt:$infmt/640x480 compose:(100,100)/640x400]"
	./media-ctl -d $mdev -V "'$dev bru':4 [fmt:$infmt/640x480]"
	./media-ctl -d $mdev -V "'$dev wpf.0':0 [fmt:$infmt/640x480]"
	./media-ctl -d $mdev -V "'$dev wpf.0':1 [fmt:$outfmt/640x480]"
	;;

m2m-crop)
	pipe_m2m

	infmt=$(pipe_format $infmt)
	outfmt=$(pipe_format $outfmt)

	./media-ctl -d $mdev -V "'$dev rpf.0':0 [fmt:$infmt/1024x768]"
	./media-ctl -d $mdev -V "'$dev wpf.0':0 [fmt:$infmt/1024x768 crop:(100,0)/640x480]"
	./media-ctl -d $mdev -V "'$dev wpf.0':1 [fmt:$outfmt/640x480]"
	;;

m2m-scale)
	pipe_m2m_scale

	infmt=$(pipe_format $infmt)
	outfmt=$(pipe_format $outfmt)

	./media-ctl -d $mdev -V "'$dev rpf.0':0 [fmt:$infmt/1024x768]"
	./media-ctl -d $mdev -V "'$dev uds.0':0 [fmt:$infmt/1024x768]"
	./media-ctl -d $mdev -V "'$dev uds.0':1 [fmt:$infmt/640x480]"
	./media-ctl -d $mdev -V "'$dev wpf.0':0 [fmt:$infmt/640x480]"
	./media-ctl -d $mdev -V "'$dev wpf.0':1 [fmt:$outfmt/640x480]"
	;;

input)
	rpf=rpf.$index
	video_get_size $rpf 0

	lcfmt=`echo $infmt | tr '[:upper:]' '[:lower:]'`
	file="frames/frame-reference-$lcfmt-$size.bin"
#	delay="-d 1000"

	./yavta $delay -c -n 4 -f $infmt -s $size --file=$file $options \
		`./media-ctl -d $mdev -e "$dev $rpf input"`
	;;

output)
	wpf=wpf.$index
	video_get_size $wpf 1

	./yavta -c10 -n 4 -f $outfmt -s $size --skip 7 -F $options \
		`./media-ctl -d $mdev -e "$dev $wpf output"`
	;;
esac


--nextPart5099964.VZ2GqrLglz--

