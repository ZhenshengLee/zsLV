<?xml version='1.0' encoding='UTF-8'?>
<Project Type="Project" LVVersion="14008000">
	<Property Name="SMProvider.SMVersion" Type="Int">201310</Property>
	<Item Name="我的电脑" Type="My Computer">
		<Property Name="IOScan.Faults" Type="Str"></Property>
		<Property Name="IOScan.NetVarPeriod" Type="UInt">100</Property>
		<Property Name="IOScan.NetWatchdogEnabled" Type="Bool">false</Property>
		<Property Name="IOScan.Period" Type="UInt">10000</Property>
		<Property Name="IOScan.PowerupMode" Type="UInt">0</Property>
		<Property Name="IOScan.Priority" Type="UInt">9</Property>
		<Property Name="IOScan.ReportModeConflict" Type="Bool">true</Property>
		<Property Name="IOScan.StartEngineOnDeploy" Type="Bool">false</Property>
		<Property Name="NI.SortType" Type="Int">3</Property>
		<Property Name="server.app.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.control.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.tcp.enabled" Type="Bool">false</Property>
		<Property Name="server.tcp.port" Type="Int">0</Property>
		<Property Name="server.tcp.serviceName" Type="Str">我的电脑/VI服务器</Property>
		<Property Name="server.tcp.serviceName.default" Type="Str">我的电脑/VI服务器</Property>
		<Property Name="server.vi.callsEnabled" Type="Bool">true</Property>
		<Property Name="server.vi.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="specify.custom.address" Type="Bool">false</Property>
		<Item Name="ctl" Type="Folder" URL="../ctl">
			<Property Name="NI.DISK" Type="Bool">true</Property>
		</Item>
		<Item Name="Coordinator_state" Type="Folder">
			<Item Name="CoordinatorUI.lvlib" Type="Library" URL="../CoordinatorUI_lib/CoordinatorUI.lvlib"/>
			<Item Name="States.lvlib" Type="Library" URL="../States_lib/States.lvlib"/>
		</Item>
		<Item Name="Map" Type="Folder">
			<Item Name="MapBuilder" Type="Folder">
				<Item Name="4F.txt" Type="Document" URL="../Map_lib/MapBuilder/4F.txt"/>
				<Item Name="5F.txt" Type="Document" URL="../Map_lib/MapBuilder/5F.txt"/>
				<Item Name="Acquire_Path_Alias_Name.vi" Type="VI" URL="../Map_lib/MapBuilder/Acquire_Path_Alias_Name.vi"/>
				<Item Name="Acquire_Path_Relation.vi" Type="VI" URL="../Map_lib/MapBuilder/Acquire_Path_Relation.vi"/>
				<Item Name="Acquire_Topology_Matrix.vi" Type="VI" URL="../Map_lib/MapBuilder/Acquire_Topology_Matrix.vi"/>
				<Item Name="Arc_to_Points.vi" Type="VI" URL="../Map_lib/MapBuilder/Arc_to_Points.vi"/>
				<Item Name="AutoDraw_Picture.vi" Type="VI" URL="../Map_lib/MapBuilder/AutoDraw_Picture.vi"/>
				<Item Name="Autogenerate_Topology_Relation.vi" Type="VI" URL="../Map_lib/MapBuilder/Autogenerate_Topology_Relation.vi"/>
				<Item Name="Cluster_to_Picture.vi" Type="VI" URL="../Map_lib/MapBuilder/Cluster_to_Picture.vi"/>
				<Item Name="data.txt" Type="Document" URL="../Map_lib/MapBuilder/data.txt"/>
				<Item Name="Deg_Rad.vi" Type="VI" URL="../Map_lib/MapBuilder/Deg_Rad.vi"/>
				<Item Name="DQ_Conjugate.vi" Type="VI" URL="../Map_lib/MapBuilder/DQ_Conjugate.vi"/>
				<Item Name="DQ_Multiplication.vi" Type="VI" URL="../Map_lib/MapBuilder/DQ_Multiplication.vi"/>
				<Item Name="DQ_transforming.vi" Type="VI" URL="../Map_lib/MapBuilder/DQ_transforming.vi"/>
				<Item Name="Draw_Path.vi" Type="VI" URL="../Map_lib/MapBuilder/Draw_Path.vi"/>
				<Item Name="Draw_SGP.vi" Type="VI" URL="../Map_lib/MapBuilder/Draw_SGP.vi"/>
				<Item Name="FormingTR_DQ.vi" Type="VI" URL="../Map_lib/MapBuilder/FormingTR_DQ.vi"/>
				<Item Name="Generate_Start_or_Goal_District_Array .vi" Type="VI" URL="../Map_lib/MapBuilder/Generate_Start_or_Goal_District_Array .vi"/>
				<Item Name="InitPic.vi" Type="VI" URL="../Map_lib/MapBuilder/InitPic.vi"/>
				<Item Name="mark.vi" Type="VI" URL="../Map_lib/MapBuilder/mark.vi"/>
				<Item Name="matrix_to_image.vi" Type="VI" URL="../Map_lib/MapBuilder/matrix_to_image.vi"/>
				<Item Name="Node_Adjust.vi" Type="VI" URL="../Map_lib/MapBuilder/Node_Adjust.vi"/>
				<Item Name="NodeAdjust.vi" Type="VI" URL="../Map_lib/MapBuilder/NodeAdjust.vi"/>
				<Item Name="PicAdjust.vi" Type="VI" URL="../Map_lib/MapBuilder/PicAdjust.vi"/>
				<Item Name="Points_to_Circle_Parameters.vi" Type="VI" URL="../Map_lib/MapBuilder/Points_to_Circle_Parameters.vi"/>
				<Item Name="Position_Show.vi" Type="VI" URL="../Map_lib/MapBuilder/Position_Show.vi"/>
				<Item Name="Read_Excel_Document_to_Cluster_Array.vi" Type="VI" URL="../Map_lib/MapBuilder/Read_Excel_Document_to_Cluster_Array.vi"/>
				<Item Name="READ_For_Something.vi" Type="VI" URL="../Map_lib/MapBuilder/READ_For_Something.vi"/>
				<Item Name="Robot_Position.ctl" Type="VI" URL="../Map_lib/MapBuilder/Robot_Position.ctl"/>
				<Item Name="Side.vi" Type="VI" URL="../Map_lib/MapBuilder/Side.vi"/>
				<Item Name="Track_Showing.vi" Type="VI" URL="../Map_lib/MapBuilder/Track_Showing.vi"/>
			</Item>
			<Item Name="Map.lvlib" Type="Library" URL="../Map_lib/Map.lvlib"/>
		</Item>
		<Item Name="Wrapper.lvlib" Type="Library" URL="../Wrapper_lib/Wrapper.lvlib"/>
		<Item Name="zsLaunch.lvlib" Type="Library" URL="../zsLaunch_lib/zsLaunch.lvlib"/>
		<Item Name="JoyStick.lvlib" Type="Library" URL="../JoyStick_lib/JoyStick.lvlib"/>
		<Item Name="Voice.lvlib" Type="Library" URL="../Voice_lib/Voice.lvlib"/>
		<Item Name="ControlPanel.lvlib" Type="Library" URL="../ControlPanel_lib/ControlPanel.lvlib"/>
		<Item Name="UnitTest.lvlib" Type="Library" URL="../UnitTest_lib/UnitTest.lvlib"/>
		<Item Name="EventsLogUI.lvlib" Type="Library" URL="../EventsLogUI_lib/EventsLogUI.lvlib"/>
		<Item Name="GlobalPlanner.lvlib" Type="Library" URL="../GlobalPlanner_lib/GlobalPlanner.lvlib"/>
		<Item Name="RemoteP3AT.lvlib" Type="Library" URL="../RemoteP3AT_lib/RemoteP3AT.lvlib"/>
		<Item Name="依赖关系" Type="Dependencies">
			<Item Name="vi.lib" Type="Folder">
				<Item Name="Acquire Input Data.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/Acquire Input Data.vi"/>
				<Item Name="Actor Framework.lvlib" Type="Library" URL="/&lt;vilib&gt;/ActorFramework/Actor Framework.lvlib"/>
				<Item Name="BuildHelpPath.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/BuildHelpPath.vi"/>
				<Item Name="Check Special Tags.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Check Special Tags.vi"/>
				<Item Name="Clear Errors.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Clear Errors.vi"/>
				<Item Name="Close Input Device.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/Close Input Device.vi"/>
				<Item Name="closeJoystick.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/closeJoystick.vi"/>
				<Item Name="closeKeyboard.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/closeKeyboard.vi"/>
				<Item Name="closeMouse.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/closeMouse.vi"/>
				<Item Name="Convert property node font to graphics font.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Convert property node font to graphics font.vi"/>
				<Item Name="Details Display Dialog.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Details Display Dialog.vi"/>
				<Item Name="DialogType.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/DialogType.ctl"/>
				<Item Name="DialogTypeEnum.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/DialogTypeEnum.ctl"/>
				<Item Name="Error Cluster From Error Code.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Error Cluster From Error Code.vi"/>
				<Item Name="Error Code Database.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Error Code Database.vi"/>
				<Item Name="ErrorDescriptions.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/ErrorDescriptions.vi"/>
				<Item Name="errorList.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/errorList.vi"/>
				<Item Name="ErrWarn.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/ErrWarn.ctl"/>
				<Item Name="eventvkey.ctl" Type="VI" URL="/&lt;vilib&gt;/event_ctls.llb/eventvkey.ctl"/>
				<Item Name="Find Tag.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Find Tag.vi"/>
				<Item Name="Format Message String.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Format Message String.vi"/>
				<Item Name="General Error Handler Core CORE.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/General Error Handler Core CORE.vi"/>
				<Item Name="General Error Handler.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/General Error Handler.vi"/>
				<Item Name="Get String Text Bounds.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Get String Text Bounds.vi"/>
				<Item Name="Get Text Rect.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Get Text Rect.vi"/>
				<Item Name="GetHelpDir.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/GetHelpDir.vi"/>
				<Item Name="GetRTHostConnectedProp.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/GetRTHostConnectedProp.vi"/>
				<Item Name="Initialize Joystick.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/Initialize Joystick.vi"/>
				<Item Name="joystickAcquire.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/joystickAcquire.vi"/>
				<Item Name="keyboardAcquire.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/keyboardAcquire.vi"/>
				<Item Name="LMH-Xbox-One-Controller.lvlib" Type="Library" URL="/&lt;vilib&gt;/MakerHub/Xbox-One-Controller/LMH-Xbox-One-Controller.lvlib"/>
				<Item Name="Longest Line Length in Pixels.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Longest Line Length in Pixels.vi"/>
				<Item Name="LVBoundsTypeDef.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/miscctls.llb/LVBoundsTypeDef.ctl"/>
				<Item Name="LVRectTypeDef.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/miscctls.llb/LVRectTypeDef.ctl"/>
				<Item Name="mouseAcquire.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/mouseAcquire.vi"/>
				<Item Name="Not Found Dialog.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Not Found Dialog.vi"/>
				<Item Name="Query Input Devices.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/inputDevices.llb/Query Input Devices.vi"/>
				<Item Name="Search and Replace Pattern.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Search and Replace Pattern.vi"/>
				<Item Name="Set Bold Text.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Set Bold Text.vi"/>
				<Item Name="Set String Value.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Set String Value.vi"/>
				<Item Name="Simple Error Handler.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Simple Error Handler.vi"/>
				<Item Name="TagReturnType.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/TagReturnType.ctl"/>
				<Item Name="Three Button Dialog CORE.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Three Button Dialog CORE.vi"/>
				<Item Name="Three Button Dialog.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Three Button Dialog.vi"/>
				<Item Name="Trim Whitespace.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Trim Whitespace.vi"/>
				<Item Name="whitespace.ctl" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/whitespace.ctl"/>
				<Item Name="UDP Multicast Open.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/tcp.llb/UDP Multicast Open.vi"/>
				<Item Name="UDP Multicast Read-Only Open.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/tcp.llb/UDP Multicast Read-Only Open.vi"/>
				<Item Name="UDP Multicast Read-Write Open.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/tcp.llb/UDP Multicast Read-Write Open.vi"/>
				<Item Name="UDP Multicast Write-Only Open.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/tcp.llb/UDP Multicast Write-Only Open.vi"/>
				<Item Name="System Exec.vi" Type="VI" URL="/&lt;vilib&gt;/Platform/system.llb/System Exec.vi"/>
				<Item Name="compatCalcOffset.vi" Type="VI" URL="/&lt;vilib&gt;/_oldvers/_oldvers.llb/compatCalcOffset.vi"/>
				<Item Name="compatOpenFileOperation.vi" Type="VI" URL="/&lt;vilib&gt;/_oldvers/_oldvers.llb/compatOpenFileOperation.vi"/>
				<Item Name="compatFileDialog.vi" Type="VI" URL="/&lt;vilib&gt;/_oldvers/_oldvers.llb/compatFileDialog.vi"/>
				<Item Name="Open_Create_Replace File.vi" Type="VI" URL="/&lt;vilib&gt;/_oldvers/_oldvers.llb/Open_Create_Replace File.vi"/>
				<Item Name="Write to XML File(array).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/xml.llb/Write to XML File(array).vi"/>
				<Item Name="Write to XML File(string).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/xml.llb/Write to XML File(string).vi"/>
				<Item Name="Write to XML File.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/xml.llb/Write to XML File.vi"/>
				<Item Name="Read From XML File.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/xml.llb/Read From XML File.vi"/>
				<Item Name="Read From XML File(array).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/xml.llb/Read From XML File(array).vi"/>
				<Item Name="ParseXMLFragments.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/xml.llb/ParseXMLFragments.vi"/>
				<Item Name="FindFirstTag.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/xml.llb/FindFirstTag.vi"/>
				<Item Name="FindEmptyElement.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/xml.llb/FindEmptyElement.vi"/>
				<Item Name="FindElement.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/xml.llb/FindElement.vi"/>
				<Item Name="FindMatchingCloseTag.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/xml.llb/FindMatchingCloseTag.vi"/>
				<Item Name="FindCloseTagByName.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/xml.llb/FindCloseTagByName.vi"/>
				<Item Name="FindElementStartByName.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/xml.llb/FindElementStartByName.vi"/>
				<Item Name="Read From XML File(string).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/xml.llb/Read From XML File(string).vi"/>
				<Item Name="Time-Delayed Send Message.vi" Type="VI" URL="/&lt;vilib&gt;/ActorFramework/Time-Delayed Send Message/Time-Delayed Send Message.vi"/>
				<Item Name="Time-Delay Override Options.ctl" Type="VI" URL="/&lt;vilib&gt;/ActorFramework/Time-Delayed Send Message/Time-Delay Override Options.ctl"/>
				<Item Name="Time-Delayed Send Message Core.vi" Type="VI" URL="/&lt;vilib&gt;/ActorFramework/Time-Delayed Send Message/Time-Delayed Send Message Core.vi"/>
				<Item Name="State Actor.lvclass" Type="LVClass" URL="/&lt;vilib&gt;/NI/Actors/State Actor/State Actor/State Actor.lvclass"/>
				<Item Name="Message Stream.lvclass" Type="LVClass" URL="/&lt;vilib&gt;/NI/Actors/Network Endpoint Actors/Abstract Classes/Message Stream/Message Stream.lvclass"/>
				<Item Name="Cipher.lvclass" Type="LVClass" URL="/&lt;vilib&gt;/NI/Actors/Network Endpoint Actors/Abstract Classes/Cipher/Cipher.lvclass"/>
				<Item Name="NI_Matrix.lvlib" Type="Library" URL="/&lt;vilib&gt;/Analysis/Matrix/NI_Matrix.lvlib"/>
				<Item Name="Read From Spreadsheet File.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Read From Spreadsheet File.vi"/>
				<Item Name="Read From Spreadsheet File (DBL).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Read From Spreadsheet File (DBL).vi"/>
				<Item Name="Read Lines From File.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Read Lines From File.vi"/>
				<Item Name="Open File+.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Open File+.vi"/>
				<Item Name="Read File+ (string).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Read File+ (string).vi"/>
				<Item Name="compatReadText.vi" Type="VI" URL="/&lt;vilib&gt;/_oldvers/_oldvers.llb/compatReadText.vi"/>
				<Item Name="Close File+.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Close File+.vi"/>
				<Item Name="Find First Error.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Find First Error.vi"/>
				<Item Name="Read From Spreadsheet File (I64).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Read From Spreadsheet File (I64).vi"/>
				<Item Name="Read From Spreadsheet File (string).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Read From Spreadsheet File (string).vi"/>
				<Item Name="IMAQ Image.ctl" Type="VI" URL="/&lt;vilib&gt;/vision/Image Controls.llb/IMAQ Image.ctl"/>
				<Item Name="IMAQ Create" Type="VI" URL="/&lt;vilib&gt;/vision/Basics.llb/IMAQ Create"/>
				<Item Name="Image Type" Type="VI" URL="/&lt;vilib&gt;/vision/Image Controls.llb/Image Type"/>
				<Item Name="NI_Kinematics.lvlib" Type="Library" URL="/&lt;vilib&gt;/robotics/Kinematics/NI_Kinematics.lvlib"/>
				<Item Name="NI_AALPro.lvlib" Type="Library" URL="/&lt;vilib&gt;/Analysis/NI_AALPro.lvlib"/>
				<Item Name="NI_AALBase.lvlib" Type="Library" URL="/&lt;vilib&gt;/Analysis/NI_AALBase.lvlib"/>
				<Item Name="Move Pen.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Move Pen.vi"/>
				<Item Name="Draw Line.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Draw Line.vi"/>
				<Item Name="Set Pen State.vi" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/Set Pen State.vi"/>
				<Item Name="Picture to Pixmap.vi" Type="VI" URL="/&lt;vilib&gt;/picture/pictutil.llb/Picture to Pixmap.vi"/>
				<Item Name="imagedata.ctl" Type="VI" URL="/&lt;vilib&gt;/picture/picture.llb/imagedata.ctl"/>
				<Item Name="Unflatten Pixmap.vi" Type="VI" URL="/&lt;vilib&gt;/picture/pixmap.llb/Unflatten Pixmap.vi"/>
				<Item Name="IMAQ ArrayToImage" Type="VI" URL="/&lt;vilib&gt;/vision/Basics.llb/IMAQ ArrayToImage"/>
				<Item Name="IMAQ Clear Overlay" Type="VI" URL="/&lt;vilib&gt;/vision/Overlay.llb/IMAQ Clear Overlay"/>
				<Item Name="IMAQ Overlay Arc" Type="VI" URL="/&lt;vilib&gt;/vision/Overlay.llb/IMAQ Overlay Arc"/>
				<Item Name="Color to RGB.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/colorconv.llb/Color to RGB.vi"/>
				<Item Name="Nested Endpoint.lvlib" Type="Library" URL="/&lt;vilib&gt;/NI/Actors/Network Endpoint Actors/Nested Endpoint/Nested Endpoint.lvlib"/>
				<Item Name="Network Endpoint.lvlib" Type="Library" URL="/&lt;vilib&gt;/NI/Actors/Network Endpoint Actors/Network Endpoint/Network Endpoint.lvlib"/>
				<Item Name="Report Error Msg.lvclass" Type="LVClass" URL="/&lt;vilib&gt;/ActorFramework/Report Error Msg/Report Error Msg.lvclass"/>
				<Item Name="TCP Stream Initiator.lvclass" Type="LVClass" URL="/&lt;vilib&gt;/NI/Actors/Network Endpoint Actors/Protocols/TCP Strategy/TCP Stream Initiator/TCP Stream Initiator.lvclass"/>
				<Item Name="TCP Stream.lvclass" Type="LVClass" URL="/&lt;vilib&gt;/NI/Actors/Network Endpoint Actors/Protocols/TCP Strategy/TCP Stream/TCP Stream.lvclass"/>
				<Item Name="Application Directory.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Application Directory.vi"/>
				<Item Name="NI_FileType.lvlib" Type="Library" URL="/&lt;vilib&gt;/Utility/lvfile.llb/NI_FileType.lvlib"/>
				<Item Name="NI_LVConfig.lvlib" Type="Library" URL="/&lt;vilib&gt;/Utility/config.llb/NI_LVConfig.lvlib"/>
				<Item Name="Check if File or Folder Exists.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/libraryn.llb/Check if File or Folder Exists.vi"/>
				<Item Name="NI_PackedLibraryUtility.lvlib" Type="Library" URL="/&lt;vilib&gt;/Utility/LVLibp/NI_PackedLibraryUtility.lvlib"/>
				<Item Name="8.6CompatibleGlobalVar.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/config.llb/8.6CompatibleGlobalVar.vi"/>
				<Item Name="TCP Stream Listener.lvclass" Type="LVClass" URL="/&lt;vilib&gt;/NI/Actors/Network Endpoint Actors/Protocols/TCP Strategy/TCP Stream Listener/TCP Stream Listener.lvclass"/>
				<Item Name="IMAQ Overlay Line" Type="VI" URL="/&lt;vilib&gt;/vision/Overlay.llb/IMAQ Overlay Line"/>
				<Item Name="IMAQ Overlay Points" Type="VI" URL="/&lt;vilib&gt;/vision/Overlay.llb/IMAQ Overlay Points"/>
				<Item Name="IMAQ Point" Type="VI" URL="/&lt;vilib&gt;/vision/Image Controls.llb/IMAQ Point"/>
				<Item Name="IMAQ Overlay Text" Type="VI" URL="/&lt;vilib&gt;/vision/Overlay.llb/IMAQ Overlay Text"/>
			</Item>
			<Item Name="lvinput.dll" Type="Document" URL="/&lt;resource&gt;/lvinput.dll"/>
			<Item Name="TestActors.lvlib" Type="Library" URL="../../../../../labview/1603/zsRobotSynergeticSystem/TestActors/TestActors.lvlib"/>
			<Item Name="zsLib.lvlib" Type="Library" URL="../../../../../labview/1603/zsRobotSynergeticSystem/zsLib/zsLib.lvlib"/>
			<Item Name="Process States.lvlib" Type="Library" URL="../../../../../labview/1512/State Pattern Actor Example/Process States/Process States.lvlib"/>
			<Item Name="Process Actor.lvlib" Type="Library" URL="../../../../../labview/1512/State Pattern Actor Example/Process Actor/Process Actor.lvlib"/>
			<Item Name="State Pattern UI.lvlib" Type="Library" URL="../../../../../labview/1512/State Pattern Actor Example/State Pattern UI/State Pattern UI.lvlib"/>
			<Item Name="Localization.vi" Type="VI" URL="../CoordinatorUI_lib/State Pattern UI/Localization.vi"/>
			<Item Name="Coordinator Actor.lvlib" Type="Library" URL="../../../../../labview/1511/zsControlSystem2.0/zsControlSystem/Coordinator Actor.lvlib"/>
			<Item Name="MapDisplayer Actor.lvlib" Type="Library" URL="../../../../../labview/1511/zsControlSystem2.0/MapDisplayer Actor/MapDisplayer Actor.lvlib"/>
			<Item Name="nivissvc.dll" Type="Document" URL="nivissvc.dll">
				<Property Name="NI.PreserveRelativePath" Type="Bool">true</Property>
			</Item>
			<Item Name="lvanlys.dll" Type="Document" URL="/&lt;resource&gt;/lvanlys.dll"/>
			<Item Name="nivision.dll" Type="Document" URL="nivision.dll">
				<Property Name="NI.PreserveRelativePath" Type="Bool">true</Property>
			</Item>
			<Item Name="Remote Endpoint P3AT Actor.lvlib" Type="Library" URL="../../../../../labview/1511/zsControlSystem2.0/Remote P3AT Actor/Remote Endpoint P3AT Actor.lvlib"/>
			<Item Name="AriaDll.dll" Type="Document" URL="../../../../../labview/1511/zsControlSystem2.0/FromOtherProject/FromWSY/dll/AriaDll.dll"/>
			<Item Name="Input Operator Actor.lvlib" Type="Library" URL="../../../../../labview/1511/zsControlSystem2.0/Input Operator Actor/Input Operator Actor.lvlib"/>
			<Item Name="JoyStick Actor.lvlib" Type="Library" URL="../../../../../labview/1511/zsControlSystem2.0/JoyStick Actor/JoyStick Actor.lvlib"/>
			<Item Name="VoiceControl Actor.lvlib" Type="Library" URL="../../../../../labview/1511/zsControlSystem2.0/Voice Control Actor/VoiceControl Actor.lvlib"/>
			<Item Name="path_plan.vi" Type="VI" URL="../../../../../labview/1511/zsControlSystem2.0/FromOtherProject/FromLXY/speech/path_plan.vi"/>
			<Item Name="path_plan6.dll" Type="Document" URL="../../../../../labview/1511/zsControlSystem2.0/FromOtherProject/FromLXY/speech/path_plan6.dll"/>
			<Item Name="get_co.dll" Type="Document" URL="../../../../../labview/1511/zsControlSystem2.0/FromOtherProject/FromLXY/speech/get_co.dll"/>
		</Item>
		<Item Name="程序生成规范" Type="Build"/>
	</Item>
</Project>
